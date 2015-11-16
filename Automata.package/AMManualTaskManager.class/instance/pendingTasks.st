accessing
pendingTasks
	^ pendingTasks ifNil: [ pendingTasks := AtomicSharedQueue new ]