Class {
	#name : 'RwCAQEvaluatorTest',
	#superclass : 'TestCase',
	#category : 'RwCAQ-Core'
}

{ #category : 'asserting' }
RwCAQEvaluatorTest >> assert: aString
evaluatesTo: expected [

	| ast result |
	ast := self parse: aString.
	result := ast evaluate.
	self
		assert: result
		equals: expected
]

{ #category : 'parsing' }
RwCAQEvaluatorTest >> parse: aString [

	^RwCAQParser new parse: aString
]

{ #category : 'running' }
RwCAQEvaluatorTest >> testBooleans [

	self
		assert: 'true'
		evaluatesTo: true.
	self
		assert: 'false'
		evaluatesTo: false
]
