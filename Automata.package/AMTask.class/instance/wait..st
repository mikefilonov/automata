call cc
wait: condition
	"template for a wait* methods"
	|newCC|
	newCC := Continuation currentDo: [ :cc | 
		self 
			saveState: cc 
			withCondition: condition.
		self ccToExecutor ].
	self loopCC: newCC.
	