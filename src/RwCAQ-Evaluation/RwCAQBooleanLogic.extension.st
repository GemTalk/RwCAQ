Extension { #name : 'RwCAQBooleanLogic' }

{ #category : 'evaluating' }
RwCAQBooleanLogic >> evaluateAndCheck: ast
in: aContext [

	|  result |
	result := ast evaluateIn: aContext.
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
		in: aContext.
	r := self
		evaluateAndCheck: right
		in: aContext.
	^l
		perform: op
		with: r
]
