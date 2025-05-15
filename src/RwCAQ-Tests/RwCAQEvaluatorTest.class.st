Class {
	#name : 'RwCAQEvaluatorTest',
	#superclass : 'TestCase',
	#instVars : [
		'context'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'asserting' }
RwCAQEvaluatorTest >> evaluating: aString
equals: expected [

	| ast result |
	ast := self parse: aString.
	result := ast evaluateIn: context.
	self
		assert: result
		equals: expected
]

{ #category : 'parsing' }
RwCAQEvaluatorTest >> parse: aString [

	^RwCAQParser new parse: aString
]

{ #category : 'running' }
RwCAQEvaluatorTest >> setUp [

	super setUp.
	context := RwCAQContext new
]

{ #category : 'running' }
RwCAQEvaluatorTest >> tearDown [

	context := nil.
	super tearDown
]

{ #category : 'running' }
RwCAQEvaluatorTest >> test_boolean [

	self
		evaluating: 'true'
		equals: true.
	self
		evaluating: 'false'
		equals: false
]

{ #category : 'running' }
RwCAQEvaluatorTest >> test_equality_is_left_associative [

	self
		evaluating: '3.7.0 = 3.7.0 = true'
		equals: true.
	self
		evaluating: 'true = 3.7.0 = 3.7.0'
		equals: false
]

{ #category : 'running' }
RwCAQEvaluatorTest >> test_equality_with_booleans [

	self
		evaluating: 'true = true'
		equals: true.
	self
		evaluating: 'true = false'
		equals: false.
	self
		evaluating: 'false = true'
		equals: false.
	self
		evaluating: 'false = false'
		equals: true
]

{ #category : 'running' }
RwCAQEvaluatorTest >> test_variable [

	self
		evaluating: 'gemstone'
		equals: false.
	context set: #'gemstone'.
	self
		evaluating: 'gemstone'
		equals: true.
	self
		evaluating: 'pharo'
		equals: false.
]
