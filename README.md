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
| OpenAI     | GPT4      | Wayne |
| GitHub     | CoPilot   | Marc |
| Google     | Gemini    | Wayne |
| Meta       | Llama3    | Wayne |

## LLM Performance Table

| LLM      | Challenge 1 | Challenge 2 | Challenge 3 | Challenge 4 | Challenge 5 |
|----------|-------------|-------------|-------------|-------------|-------------|
| Claude   | Pass        | In progress        | In progress        | In progress        | In progress        |
| GPT4     | In progress        | In progress        | In progress        | In progress        | In progress        |
| CoPilot  | In progress        | In progress        | In progress        | In progress        | In progress        |
| Gemini   | In progress        | In progress        | In progress        | In progress        | In progress        |
| Llama3   | In progress        | In progress        | In progress        | In progress        | In progress        |


### TO DO:
- [x] Gather VHDL SME Docs
- [x] Gather VHDL Questions
- [ ] Test/Validate LLM(s)
- [ ] Write some sort of report
