Extension { #name : 'RwCAQBooleanLogic' }

{ #category : 'evaluating' }
RwCAQBooleanLogic >> evaluateAndCheck: ast
in: aContext
ifSentinel: aBlock [

	|  result |
	result := ast evaluateIn: aContext.
	result class == RwCAQSentinel
		ifTrue: [^aBlock cull: result].
	^(result == true) | (result == false)
		ifTrue: [result]
		ifFalse: [RwCAQBooleanExpected
				signalExpression: self
				subexpression: ast
				operand: result]
]

{ #category : 'evaluating' }
RwCAQBooleanLogic >> evaluateIn: aContext [

	| l r |
	l := self
		evaluateAndCheck: left
		in: aContext
		ifSentinel: [false].
	r := self
		evaluateAndCheck: right
		in: aContext
		ifSentinel: [false].
	^l
		perform: op
		with: r
]
