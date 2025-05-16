Extension { #name : 'RwCAQBinaryCompare' }

{ #category : 'evaluating' }
RwCAQBinaryCompare >> evaluateIn: aContext [

	| l r |
	l := left evaluateIn: aContext.
	r := right evaluateIn: aContext.
	l class == RwCAQSentinel
		ifTrue: [^false].
	r class == RwCAQSentinel
		ifTrue: [^false].
	^l
		perform: op
		with: r
]
