call cc
waitEvent: condition
	|savedEvent closureCondition|
	
	closureCondition := [ :event | (condition value: event) ifTrue:[ savedEvent := event. true ] ifFalse: [ false ]  ].
	self wait: closureCondition.
	^savedEvent.
