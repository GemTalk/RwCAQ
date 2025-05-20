Extension { #name : 'RwCAQBinaryCompare' }

{ #category : 'evaluating' }
RwCAQBinaryCompare >> evaluateAndCheck: ast
in: aContext
ifSentinel: aBlock [

	|  result |
	result := ast evaluateIn: aContext.
	result class == RwCAQSentinel
		ifTrue: [^aBlock cull: result].
	^result class == RwGemStoneVersionNumber
		ifTrue: [result]
		ifFalse: [RwCAQComparableExpected
				signalExpression: self
				subexpression: ast
				operand: result]
]

{ #category : 'evaluating' }
RwCAQBinaryCompare >> evaluateIn: aContext [

	| l r |
	l := self
		evaluateAndCheck: left
		in: aContext
		ifSentinel: [^false].
	r := self
		evaluateAndCheck: right
		in: aContext
		ifSentinel: [^false].
	^l
		perform: op
		with: r
]

{ #category : 'testing' }
RwCAQBinaryCompare >> isComparable: anObject [

	^anObject class == RwGemStoneVersionNumber
]
