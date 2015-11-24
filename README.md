# Pharo Automata - automation base framework

Automata allows you to run code which can be explicitly "paused" and then "resumed" on arrival of an external event.

The project is inspired by Seaside WATask class providing a developer a way to have a explicit code flow for complex tasks.

Automata can be hooked to any event system by implementing AMTaskManager callbacks protocol. 
As an example  see ```AMManualTaskManager``` class which implement a FIFO for pending tasks and manual event management.

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
