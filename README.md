# Pharo Automata
Microservices automation framework - the "main" function to drive external APIs.

Automata framework is build to automate external microservices communication by allowing code to be explicitly "paused" and then "resumed" on an arrival of an event from an external system. The project is inspired by Seaside ```WATask``` class providing a developer a way to have a explicit code for complex workflows.

The idea is to have some kind of a state machine which is driving external services by (REST) API and changing it's state depending based on events recieved back. The state machine is represented by a Smalltalk code and "waitForEvent:" method which saves current execution state and resumes it upon a recieving of an event.

Automata state machine can be hooked to any event system by inheriting AMTaskManager and implementing ```callbacks``` protocol.

As an example see ```AMManualTaskManager``` class which implements a FIFO queue for pending tasks and manual event triggering.

##Installation

```
Metacello new baseline: #Automata; repository: 'github://mikefilonov/automata'; load.
```

## Quick start
The following is an example code which runs on ```AMManualTaskManager``` implementation. 
First, the code creates two tasks which are stoped and some points in code (```wait: nil```).
Second, the code starts the execution loop and manually sends ```doNext``` code to resume next pending task.

Just run the following code in Pharo Playground:

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

##Implementation details


By default Automata implements single-threaded execution loop in which runable tasks are queued and exected in FIFO.

For more implementation details please refer to RESTAnnouncer project at https://github.com/mikefilonov/restannouncer
