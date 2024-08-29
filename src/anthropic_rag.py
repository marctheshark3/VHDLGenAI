import os
from typing import List, Dict, Any
import anthropic
from anthropic import HUMAN_PROMPT, AI_PROMPT
import glob
import json

class VHDLDocument:
    def __init__(self, content: str, doc_id: str, source: str, difficulty: str):
        self.content = content
        self.doc_id = doc_id
        self.source = source
        self.difficulty = difficulty  # e.g., "beginner", "intermediate", "advanced"

class VHDLDocumentStore:
    def __init__(self):
        self.documents: List[VHDLDocument] = []

    def add_document(self, document: VHDLDocument):
        self.documents.append(document)

    def get_all_documents(self) -> List[VHDLDocument]:
        return self.documents

    def get_documents_by_difficulty(self, difficulty: str) -> List[VHDLDocument]:
        return [doc for doc in self.documents if doc.difficulty == difficulty]

class VHDLLoader:
    @staticmethod
    def load_vhdl_file(file_path: str) -> str:
        with open(file_path, 'r') as file:
            return file.read()

    @staticmethod
    def load_vhdl_from_directory(directory: str) -> List[VHDLDocument]:
        documents = []
        for file_path in glob.glob(os.path.join(directory, '*.vhd')):
            content = VHDLLoader.load_vhdl_file(file_path)
            doc_id = os.path.basename(file_path)
            difficulty = VHDLLoader.infer_difficulty(content)
            documents.append(VHDLDocument(content, doc_id, file_path, difficulty))
        return documents

    @staticmethod
    def infer_difficulty(content: str) -> str:
        # Define keywords and structures for each difficulty level
        beginner_keywords = ['entity', 'port', 'architecture', 'process', 'signal', 'std_logic']
        intermediate_keywords = ['generic', 'component', 'function', 'procedure', 'package', 'type', 'record']
        advanced_keywords = ['generate', 'attribute', 'configuration', 'alias', 'group', 'impure function']

        # Count occurrences of keywords for each difficulty level
        beginner_count = sum(content.count(keyword) for keyword in beginner_keywords)
        intermediate_count = sum(content.count(keyword) for keyword in intermediate_keywords)
        advanced_count = sum(content.count(keyword) for keyword in advanced_keywords)

        # Check for specific advanced structures
        has_complex_fsm = bool(re.search(r'type\s+\w+\s+is\s*\(.*\);.*\w+\s*<=\s*\w+', content, re.DOTALL))
        has_complex_datapath = bool(re.search(r'component.*port map', content, re.DOTALL))

        # Determine difficulty based on keyword counts and structures
        if advanced_count > 0 or has_complex_fsm or has_complex_datapath:
            return "advanced"
        elif intermediate_count > 0 or beginner_count > 10:
            return "intermediate"
        else:
            return "beginner"

class AnthropicVHDLRAG:
    def __init__(self, api_key: str):
        self.client = anthropic.Anthropic(api_key=api_key)
        self.document_store = VHDLDocumentStore()
        self.conversation_history = []

    def add_documents(self, documents: List[VHDLDocument]):
        for doc in documents:
            self.document_store.add_document(doc)

    def load_vhdl_from_directory(self, directory: str):
        documents = VHDLLoader.load_vhdl_from_directory(directory)
        self.add_documents(documents)

    def generate_response(self, query: str, code: str = None, difficulty: str = None) -> str:
        relevant_docs = self.document_store.get_documents_by_difficulty(difficulty) if difficulty else self.document_store.get_all_documents()
        
        context = "\n".join([f"Source: {doc.source}\nDifficulty: {doc.difficulty}\nContent: {doc.content[:500]}..." for doc in relevant_docs])
        
        conversation_context = "\n".join(self.conversation_history[-5:])
        
        prompt = f"{HUMAN_PROMPT} Context:\n{context}\n\nConversation history:\n{conversation_context}\n\nQuestion: {query}\n"
        
        if code:
            prompt += f"\nVHDL Code:\n{code}\n"
        
        prompt += f"\nPlease provide a response and also return any relevant VHDL code.{AI_PROMPT}"

        response = self.client.messages.create(
            model="claude-3-opus-20240229",
            max_tokens=2000,
            messages=[{"role": "user", "content": prompt}],
            system="You are a helpful VHDL programming assistant. Always provide your response in JSON format with 'answer', 'vhdl_code', and 'sources' keys.",
        )
        
        response_content = json.loads(response.content[0].text)
        
        self.conversation_history.append(f"Human: {query}")
        self.conversation_history.append(f"AI: {response_content['answer']}")

        return response_content

def main():
    api_key = os.getenv("ANTHROPIC_API_KEY")
    if not api_key:
        raise ValueError("ANTHROPIC_API_KEY environment variable not set")

    vhdl_rag = AnthropicVHDLRAG(api_key)

    # Load VHDL files from a directory
    vhdl_directory = "path/to/your/vhdl/tutorials"
    vhdl_rag.load_vhdl_from_directory(vhdl_directory)

    # Example usage
    query1 = "Can you explain how to declare a simple entity in VHDL?"
    response1 = vhdl_rag.generate_response(query1, difficulty="beginner")
    print(f"Query: {query1}")
    print(f"Answer: {response1['answer']}")
    print(f"VHDL Code: {response1['vhdl_code']}")
    print(f"Sources: {response1['sources']}")

    query2 = "Can you help me implement a complex finite state machine in VHDL?"
    response2 = vhdl_rag.generate_response(query2, difficulty="advanced")
    print(f"\nQuery: {query2}")
    print(f"Answer: {response2['answer']}")
    print(f"VHDL Code: {response2['vhdl_code']}")
    print(f"Sources: {response2['sources']}")

if __name__ == "__main__":
    main()