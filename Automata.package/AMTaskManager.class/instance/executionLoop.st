accessing
executionLoop
	^executionLoop ifNil: [ executionLoop := AMExecutionLoop new ]