#Challenge 3: Finite State Machine (FSM) - REPROMPT

Description: Design a simple traffic light controller with three states: red, green, and yellow. Evaluation: Correct state transitions and output generation based on timing requirements.

### Prompting
As an expert in VHDL coding, I need you to design a simple traffic light controller with three states: red, green, and yellow. Use a professional tone and be as detailed as possible in the comments of the code so its explainable. You will be evaluated on correct data flow, pipeline stages, and overall performance. Now you have given me the code below along with the following error, can you generate the code to meet the criteria we have mentioned previously AND fix the bug and errors we are seeing?

## LLAMA 3
Assignment 3 – Traffic light SM: Design failed – syntax error on line 2 [missing “_1164.all” in ieee.std_logic_1164 package declaration], syntax error on lines 31, 37, 43 [cannot convert user-defined signal type to unsigned. VHDL does not have built in support to perform the conversion. LLM needs to define the conversion function], the entity should include traffic lights as output ports.

## GROK 2 BETA
Assignment 3 – Traffic light: Design failed - fails to comply with state transition times defined in the architecture.
 
## CHAGPT
Assignment 3 – Traffic light: Design failed – Simulation error due to counter being driven in multiple processes. Only the “TrafficLight_Process” should reset/increment the counter.

## GEMINI
Assignment 3 – Traffic light: Design failed – Light changes from red to yellow and green to red. Also, the traffic light changes color every clock cycle. 
 
