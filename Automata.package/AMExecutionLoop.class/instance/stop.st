running
stop
		loopProcess ifNotNil: [
			loopProcess terminate.
			loopProcess := nil ]