Extension { #name : 'RwCAQBooleanLogic' }

{ #category : 'evaluating' }
RwCAQBooleanLogic >> evaluateIn: aContext [

	| l r |
	l := left evaluateIn: aContext.
	r := right evaluateIn: aContext.
	((l == true) | (l == false))
		ifFalse: [RwCAQError signal].
	((r == true) | (r == false))
		ifFalse: [RwCAQError signal].
	^l
		perform: op
		with: r
]
