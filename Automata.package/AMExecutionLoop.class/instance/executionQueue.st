accessing
executionQueue
	^ executionQueue ifNil: [ executionQueue := AtomicSharedQueue new ]