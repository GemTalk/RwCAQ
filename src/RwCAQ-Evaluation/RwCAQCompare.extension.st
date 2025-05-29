Extension { #name : 'RwCAQCompare' }

{ #category : 'evaluating' }
RwCAQCompare >> evaluateAndCheck: ast
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
RwCAQCompare >> evaluateIn: aContext [

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
		perform: self selector
		with: r
]
