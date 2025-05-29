Extension { #name : 'RwCAQEquality' }

{ #category : 'evaluating' }
RwCAQEquality >> evaluateIn: aContext [

	| l r |
	l := left evaluateIn: aContext.
	r := right evaluateIn: aContext.
	^l
		perform: self selector
		with: r
]
