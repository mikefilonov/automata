running
start
		loopProcess ifNil: [ 
			loopProcess := [ 
				[ self executeNext ] repeat ] fork ]