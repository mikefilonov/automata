# Pharo Automata
Microservices automation framework - the "main" function to drive external APIs.

Automata framework is build to automate external microservices communication by allowing code to be explicitly "paused" and then "resumed" on an arrival of an event from an external system. The project is inspired by Seaside ```WATask``` class providing a developer a way to have a explicit code for complex workflows.

The idea is to have some kind of a state machine which drives external services via (REST) API and changes it's state  based on events recieved back. The state machine is represented by a Smalltalk code and "waitForEvent:" method which saves current execution state and resumes it upon a recieving of an event.

Automata state machine can be hooked to any event system by inheriting ```AMTaskManager``` and implementing ```callbacks``` protocol.

As an example implementaion see ```AMManualTaskManager``` class which implements a FIFO queue for pending tasks and manual event triggering.

##Installation

```
Metacello new baseline: #Automata; repository: 'github://mikefilonov/automata'; load.
```

## Quick start
The following example uses ```AMManualTaskManager``` implementation to run tasks. Note that by "event" we mean an explicit call to "doNext" method.

Run the following code in Pharo Playground:

```smalltalk
automata := AMManualTaskManager new.
automata do: [ :task |
	Transcript show: 'Hello'.
	task wait: nil.
	Transcript show: 'World!'.
	].

automata do: [ :task |
	Transcript show: 'Goodbye'.
	task wait: nil.
	Transcript show: 'Cruel'.
	task wait: nil.
	Transcript show: 'World :('.	
	task wait: nil.
	].

automata start.

automata doNext.
automata doNext.
automata doNext.
automata doNext.

automata stop.
```


## Using Automata

### ```#do:``` and ```#doTask:``` methods
A task manager (AMTaskManager subclasses) is used to track execution of many tasks. in order to start a new task ```doTask:``` method is used. The method accepts one argument which is a AMTask subclass instance to run

You may also want to use ```do:``` method which is a shorthand for ```AMDeligateTask``` which is build around a block of code, which is passed as an argument. The block must accept one argument which is a task itself

### ```#wait:``` and ```#waitForEvent:``` methods

Automata task saves it's state using ```wait:``` method. This method accepts 1 argument (condition) which is not restricted to any class by automata but defined by a concrete imoplementation of event system. The argument is called "condition" and it's purpose to define a resume condition. The intended way to use it is a Block which accepts an event and returns ```true``` or ```false``` depending on if the event matches the expected description.

```waitForEvent:``` is an helper method which assumes that condition is to be a block with one argument (suposedly an event) and returns the argument for which the block answered ```true```.

```
event := task waitForEvent: [:event | event selector = #FileUploaded].
Transcript show: (event at: #filename).
```

### AMTaskManager callback protocol

To implement an new automata manager for an event system create a new AMTaskManager subclass and re-implement ```addPendingTask: aTask withState: cc withCondition: condition```

where
- ```aTask``` is a AMTask instance which represents the code flow and can be used to store some flow-specific properties like "task name".
- ```cc``` is a Continuation which should be used to resume the task.
- ```condition``` is a condition to resume the flow. Defined by the concrete implementation.

This method is called whenever a task reaches ```wait:``` method. In a response a task manager is supposed to save the task in a "pending tasks" collection and resume it when event matching ```condition``` is recieved.

The framework does not provide a default implenentation to store and resume tasks though. This means the task manager implementation must have some kind of a queue for tasks and event processor which runs through conditions and put matched ```cc``` to execution loop queue.

### Resuming a pending task

In order to resume a saved task it's latest ```cc``` should be put to an execution loop queue:

```smalltalk
automata executionLoop enqueue: cc
```


## Implementation details

By default Automata implements single-threaded execution loop in which runable tasks are queued and exected in FIFO order.

For more implementation details please refer to RESTAnnouncer project at https://github.com/mikefilonov/restannouncer
