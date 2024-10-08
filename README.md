# VHDLGenAI

## VDHL Needs
1. What is a good asic simulator we can run
There are proprietary and free VHDL simulators listed here: https://en.m.wikipedia.org/wiki/List_of_HDL_simulators

## LLM VHDL Coding Questions
1. Challenge 1: Simple Combinational Logic
* Description: Design a 4-bit adder using basic logic gates.
* Evaluation: Correctness of the adder's output for all possible input combinations.
2. Challenge 2: Sequential Logic with Clock
* Description: Design a synchronous D flip-flop with enable input.
* Evaluation: Correct data storage and output behavior based on clock and enable signals.
3. Challenge 3: Finite State Machine (FSM)
* Description: Design a simple traffic light controller with three states: red, green, and yellow.
* Evaluation: Correct state transitions and output generation based on timing requirements.
4. Challenge 4: Pipelined Data Path
* Description: Design a simple 4-stage pipeline for a multiplier.
* Evaluation: Correct data flow, pipeline stages, and overall performance.
5. Challenge 5: Parameterized Design Entity
* Description: Create a generic n-bit shift register with configurable shift direction.
* Evaluation: Correct functionality for different bit widths and shift directions.

These challenges progressively increase in complexity, testing the LLM's ability to understand and apply VHDL concepts, from basic logic gates to advanced design techniques like pipelining and parameterization.

Five VHDL and FPGA Design Questions
Easy
Explain the difference between a synchronous and asynchronous reset in VHDL.
Medium
Describe the process of timing closure in FPGA design and the role of constraints in achieving it.
Hard
How would you optimize a high-speed data path in an FPGA to minimize latency and power consumption?
Very Hard
Discuss the trade-offs between using a hard IP core versus a soft IP core for a specific function in an FPGA design.
Expert
Design a self-timed element using VHDL and explain how it can be used to create a fully asynchronous system. What are the challenges and benefits of such an approach?

## Question Types to LLM(S)
1. Write this code for me
2. Given this code write a tutorial
3. Explain this code

By reframing some of the coding questions to the above questions we can see if one it can solve the problem but how well it is at understanding how to solve and steps to solve it

## LLM's Being Used
| Company    | Model     | Contact |
|------------|-----------|---------|
| Anthropic  | Claude    | Marc |
| OpenAI     | GPT4      | Marc |
|<del>GitHub</dev> | <del>CoPilot</dev> | <del>Marc</dev> |
| Google     | Gemini    | Wayne |
| Meta       | Llama3    | Marc |
| X          | Grok 2 (betA) | Marc |
| Codeium    | ??? | Marc |

## LLM Performance Table
### First Pass Through
| LLM      | Challenge 1 | Challenge 2 | Challenge 3 | Challenge 4 | Challenge 5 | RAG (Y/N) |
|----------|-------------|-------------|-------------|-------------|-------------|-------------|
| Claude   | Pass        | Pass        | Pass        | Failed        | Pass        | Y |
| GPT4     | Pass | Failed | Failed | Failed | Pass | Y |
| <del>CoPilot</dev>  | OBE | OBE | OBE | OBE | OBE | OBS |
| Gemini   | Failed | Failed | Failed | Failed | Failed | N |
| Llama3   | Failed | Failed | Failed | Failed | Failed | N |
| Grok 2   | Failed | Pass | Failed | Failed | Pass | N |
| Codeium   | Reviewing | Reviewing | Reviewing | Reviewing | Reviewing | Y |


### Second Pass Through - REPROMPTING
| LLM      | Challenge 1 | Challenge 2 | Challenge 3 | Challenge 4 | Challenge 5 | RAG (Y/N) |
|----------|-------------|-------------|-------------|-------------|-------------|-------------|
| Claude   | NA        | NA        | NA        | REPROMPTING        | NA        | Y |
| GPT4     | NA | REPROMPTING | REPROMPTING | REPROMPTING | NA | Y |
| Gemini   | REPROMPTING | REPROMPTING | REPROMPTING | REPROMPTING | REPROMPTING | N |
| Llama3   | REPROMPTING | REPROMPTING | REPROMPTING | REPROMPTING | REPROMPTING | N |
| Grok 2   | REPROMPTING | NA | REPROMPTING | REPROMPTING | NA | N |


### TO DO:
- [x] Gather VHDL SME Docs
- [x] Gather VHDL Questions
- [ ] Test/Validate LLM(s)
- [ ] Write some sort of report

### Notes
Github Copilot has been deemed as OBE due to this LLM being trained on gits repositories and the amount if VHDL code is small. In terms of use case Github's CoPilot would be great to use and recreate. This sort of capability is similar to Continue as VS code plugin.
