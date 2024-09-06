# Challenge 2

Sequential Logic with Clock
Description: Design a synchronous D flip-flop with enable input.
Evaluation: Correct data storage and output behavior based on clock and enable signals.

## Prompting
Custom Instructions:
Use a professional tone, as you are an expert in the VHDL coding language. Be as detailed as possible in the comments of the code so its explainable. 

Prompt:
I need you to design a synchronous D flip-flop with enable input. You will be evaluated on correct data storage and output behavior based on clock and enable signals.

Llama3/Grok2/chagpt/gemini: 
As an expert in VHDL coding, I need you to design a synchronous D flip-flop with enable input. Use a professional tone and be as detailed as possible in the comments of the code so its explainable. You will be evaluated on correct data flow, pipeline stages, and overall performance.

Llama 3 response:
**Explanation:**

This VHDL code defines a synchronous D flip-flop with an enable input, which means that the flip-flop is only updated when the 
clock edge occurs and the enable input is high.

* *Internal Signals:* We define two internal signals: `Reg_D` and `Next_State`. `Reg_D` represents the current state of the 
register, while `Next_State` represents the next state.
* *Flip-Flop Logic:* The flip-flop logic is implemented in a VHDL process that takes into account the clock input `Clock`, the D 
input `D`, and the enable input `E`.
	+ When the clock edge occurs (`rising_edge(Clock)`), we check if the enable input is high (`E = '1'`). If it is, we update the 
register with the new value of `D` (`Reg_D <= D`).
* *Output Assignments:* We assign the output values as follows:
	+ `Q` represents the current state of the register and is assigned the value of `Reg_D`.
	+ `Q_not` represents the inverted value of `Q` (i.e., the complement of the register's state) and is assigned the result of `not
Reg_D`.

**Performance Evaluation:**

The performance of this flip-flop can be evaluated based on the following metrics:

* *Cycle Time:* The clock period required for each update operation.
* *Latency:* The number of clock cycles required to produce the final output (in this case, 1 cycle).
* *Throughput:* The maximum number of updates that can be performed per unit time (dependent on the clock frequency).

In terms of data flow, this flip-flop has a single pipeline stage:
* **Stage 0:** Update the register with the new value when the clock edge occurs and the enable input is high.

Overall, this synchronous D flip-flop with an enable input has a low latency and can handle up to one update operation per clock 
cycle, making it suitable for applications that require predictable and reliable data storage.

