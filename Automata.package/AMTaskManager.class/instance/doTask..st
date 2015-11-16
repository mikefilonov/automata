running
doTask: aTask
	self executionLoop enqueueTask: (aTask manager: self; yourself)