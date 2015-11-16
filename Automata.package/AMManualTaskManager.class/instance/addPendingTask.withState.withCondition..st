callbacks
addPendingTask: aTask withState: cc withCondition: condition
	"abstract condition, can be anything"
	self pendingTasks nextPut: aTask->cc