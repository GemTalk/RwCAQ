Class {
	#name : 'RwCAQEvaluatorTest',
	#superclass : 'TestCase',
	#instVars : [
		'context'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'context management' }
RwCAQEvaluatorTest >> clearContext [
	"Make the context empty"

	context := RwCAQContext new
]

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

{ #category : 'context management' }
RwCAQEvaluatorTest >> prepareContext [
	"Load all of the implicit variables into context."

	context
		set: #'gemstone'.
	context
		set: #'gemstone.version'
		to: ((System gemVersionReport at: 'gsVersion') asRwGemStoneVersionNumber)
]

{ #category : 'running' }
RwCAQEvaluatorTest >> setUp [

	super setUp.
	context := RwCAQContext new.
	self prepareContext
]

{ #category : 'running' }
RwCAQEvaluatorTest >> tearDown [

	context := nil.
	super tearDown
]

{ #category : 'running-trivial' }
RwCAQEvaluatorTest >> test_boolean [

	self
		evaluating: 'true'
		equals: true.
	self
		evaluating: 'false'
		equals: false
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_compare [

	self
		evaluating: 'gemstone.version > 3.0'
		equals: true.
	self
		evaluating: 'gemstone.version >= 3.0'
		equals: true.
	self
		evaluating: 'gemstone.version <= 3.0'
		equals: false.
	self
		evaluating: 'gemstone.version < 3.0'
		equals: false
]

{ #category : 'running-composed' }
RwCAQEvaluatorTest >> test_compare_and_equality [

	self
		evaluating: 'gemstone.version >= 3.0 = true'
		equals: true.
	self
		evaluating: 'gemstone.version < 3.0 = false'
		equals: true.
	self
		evaluating: 'true = gemstone.version >= 3.0'
		equals: true.
	self
		evaluating: 'false = gemstone.version < 3.0'
		equals: true
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_equality [

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

{ #category : 'running-composed' }
RwCAQEvaluatorTest >> test_equality_and_logic [

	self
		evaluating: 'test.version = 3.0 | false'
		equals: false.
	context
		set: #'test.version'
		to: '3.0' asRwGemStoneVersionNumber.
	self
		evaluating: 'test.version = 3.0 | false'
		equals: true.
	self
		evaluating: 'false | test.version = 3.0'
		equals: true.
	self
		evaluating: 'false | test.version = 3.1'
		equals: false.
	self
		evaluating: 'test.version = 3.1 | false'
		equals: false.
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_equality_is_left_associative [

	self
		evaluating: '3.7.0 = 3.7.0 = true'
		equals: true.
	self
		evaluating: 'true = 3.7.0 = 3.7.0'
		equals: false
]

{ #category : 'running-trivial' }
RwCAQEvaluatorTest >> test_variable [

	self clearContext.
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
