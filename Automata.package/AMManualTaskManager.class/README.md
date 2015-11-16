I'm a sample implementation of Task Manager which ignores a condition of wait and just stores saved states in a queue.

To run next pending Task run doNext.

Example:
manager := RSManualTaskManager new.

manager do: [ :task |
	Transcript show: 'Hello'.
	task wait: nil.
	Transcript show: 'World!'.
	].

manager do: [ :task |
	Transcript show: 'Goodbye'.
	task wait: nil.
	Transcript show: 'Cruel'.
	task wait: nil.
	Transcript show: 'World :('.	
	].

manager executionLoop start.

manager doNext.
manager doNext.
manager doNext.
manager doNext.

manager executionLoop stop.
