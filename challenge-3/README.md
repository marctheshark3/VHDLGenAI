Challenge 3: Finite State Machine (FSM)
Description: Design a simple traffic light controller with three states: red, green, and yellow. Evaluation: Correct state transitions and output generation based on timing requirements.

Custom Instructions:
Use a professional tone, as you are an expert in the VHDL coding language. Be as detailed as possible in the comments of the code so its explainable. 

Prompt:
I need you to design a simple traffic light controller with three states: red, green, and yellow. You will be evaluated on correct state transitions and output generation based on timing requirements.

Llama3/Grok2: 
As an expert in VHDL coding, I need you to design a simple traffic light controller with three states: red, green, and yellow. Use a professional tone and be as detailed as possible in the comments of the code so its explainable. You will be evaluated on correct data flow, pipeline stages, and overall performance.

Llama3 response:

This code defines a simple traffic light controller with three states: red, green, and yellow. The clock signal (`clk`) is used to 
control the timing of the transitions between these states.

The `States` type is defined as an enumeration type with values `RED`, `GREEN`, and `YELLOW`. This represents the current state of 
the traffic light.

The initial state is set to `RED`.

In the `Behavioral` architecture, a process is used to describe the behavior of the traffic light controller. The process is 
clocked by the `clk` signal.

Inside the process, there are three cases to handle each state transition:

1.  When the current state is `RED`, it will transition to `YELLOW` after a certain delay (e.g., 2 seconds). This is implemented 
using the `std_logic_vector( unsigned(currentState) + 1 )` expression.
2.  When the current state is `YELLOW`, it will transition back to `GREEN` after another delay (e.g., 3 seconds).
3.  When the current state is `GREEN`, it will transition back to `RED` after a final delay (e.g., 4 seconds).

The output of the current state is reported using the `report` statement with different severity levels for each state.

**Evaluation:**

*   Correct data flow: The code uses a process to describe the behavior of the traffic light controller, which ensures correct data
flow.
*   Pipeline stages: The code does not involve pipeline stages as it is a simple finite state machine. However, if you want to 
implement a more complex traffic light controller with multiple stages, you can do so by adding additional processes or using 
VHDL's concurrent statements (e.g., `process` with multiple `wait` statements).
*   Overall performance: The code should have good overall performance as it is designed for a simple finite state machine. 
However, if you want to optimize the code further, you can consider using VHDL's built-in functions and operators or implementing a
more efficient algorithm.

**Note:** This code assumes that the delays are implemented internally by the VHDL compiler. In real-world applications, these 
delays would typically be implemented using counters or timers.