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
	(self isComparable: l)
		ifFalse: [RwCAQError signal].
	(self isComparable: r)
		ifFalse: [RwCAQError signal].
	^l
		perform: op
		with: r
]

{ #category : 'testing' }
RwCAQBinaryCompare >> isComparable: anObject [

	^anObject class == RwGemStoneVersionNumber
]
