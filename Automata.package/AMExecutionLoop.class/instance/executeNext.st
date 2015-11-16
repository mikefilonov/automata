private
executeNext
	| nextBlock |
	nextBlock := self executionQueue next.
	Continuation currentDo: [ :cc | nextBlock value: cc ].
	