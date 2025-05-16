Extension { #name : 'RwCAQBooleanLogic' }

{ #category : 'evaluating' }
RwCAQBooleanLogic >> evaluateIn: aContext [

	| l r |
	l := left evaluateIn: aContext.
	r := right evaluateIn: aContext.
	^l
		perform: op
		with: r
]
