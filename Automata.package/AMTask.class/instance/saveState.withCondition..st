call cc
saveState: cc withCondition: condition
	"Put {self. cc} state to a pending queue"
	self manager addPendingTask: self withState: cc withCondition: condition