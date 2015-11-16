running
enqueueTask: aTask
	"start a RSTask, wrapping it in a Block"
	self enqueue: [ :cc | 
		aTask
			loopCC: cc;
			execute ]