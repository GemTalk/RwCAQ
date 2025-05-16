Extension { #name : 'RwCAQBinaryCompare' }

{ #category : 'evaluating' }
RwCAQBinaryCompare >> evaluateIn: aContext [

	| l r |
	l := left evaluateIn: aContext.
	r := right evaluateIn: aContext.
	^l
		perform: op
		with: r
]
