Class {
	#name : 'RwCAQParserTest',
	#superclass : 'TestCase',
	#category : 'RwCAQ-Core'
}

{ #category : 'asserting' }
RwCAQParserTest >> parse: aString [
	"Return an AST for the provided string."

	^self parser parse: aString
]

{ #category : 'accessing' }
RwCAQParserTest >> parser [

	^RwCAQParser new
]

{ #category : 'asserting' }
RwCAQParserTest >> parsing: aString
equals: expected [

	| actual |
	actual := self parse: aString.
	self
		assert: actual
		equals: expected
]

{ #category : 'testing-productions' }
RwCAQParserTest >> test_boolean [
	"Parse false"

	self
		parsing: 'true'
		equals: (RwCAQPrimitive value: true).
	self
		parsing: 'truex'
		equals: (RwCAQVariable name: #'truex').
	self
		parsing: 'false'
		equals: (RwCAQPrimitive value: false).
	self
		parsing: 'falsex'
		equals: (RwCAQVariable name: #'falsex').
]

{ #category : 'testing-productions' }
RwCAQParserTest >> test_equality [
	"Parse an equality statement"

	| expected |
	expected := RwCAQEquality
		left: (RwCAQVariable name: #'gemstone.version')
		right: (RwCAQPrimitive value: (RwGemStoneVersionNumber fromString: '42')).
	self
		parsing: 'gemstone.version = 42'
		equals: expected.
	expected := RwCAQEquality
		left: (RwCAQVariable name: #'tests')
		right: (RwCAQPrimitive value: true).
	self
		parsing: 'tests = true'
		equals: expected
]

{ #category : 'testing-productions' }
RwCAQParserTest >> test_equality_is_left_associative [

	| expected left |
	left := RwCAQEquality
		left: (RwCAQPrimitive value: true)
		right: (RwCAQPrimitive value: false).
	expected := RwCAQEquality
		left: left
		right: (RwCAQPrimitive value: true).
	self
		parsing: 'true = false = true'
		equals: expected
]

{ #category : 'testing-productions' }
RwCAQParserTest >> test_equality_variable_spacing [
	"Parse an equality statement"

	| expected |
	expected := RwCAQEquality
		left: (RwCAQVariable name: #'gemstone.version')
		right: (RwCAQPrimitive value: (RwGemStoneVersionNumber fromString: '42')).
	self
		parsing: 'gemstone.version          =42'
		equals: expected.
	self
		parsing: 'gemstone.version=         42'
		equals: expected
]

{ #category : 'testing-productions' }
RwCAQParserTest >> test_variable [
	"Parse solo identifiers"

	|  ast expected |
	ast := self parse: 't'.
	expected := RwCAQVariable name: #'t'.
	self
		assert: ast
		equals: expected.
	ast := self parse: 't '.
	expected := RwCAQVariable name: #'t'.
	self
		assert: ast
		equals: expected.

	ast := self parse: 'tests'.
	expected := RwCAQVariable name: #'tests'.
	self
		assert: ast
		equals: expected.

	ast := self parse: 'tests.smoke1'.
	expected := RwCAQVariable name: #'tests.smoke1'.
	self
		assert: ast
		equals: expected.

	ast := self parse: 'tests1.smoke.regression'.
	expected := RwCAQVariable name: #'tests1.smoke.regression'.
	self
		assert: ast
		equals: expected.

	ast := self parse: 'tests1....smoke.regression'.
	expected := RwCAQVariable name: #'tests1....smoke.regression'.
	self
		assert: ast
		equals: expected.
]

{ #category : 'testing-productions' }
RwCAQParserTest >> test_version [
	"GemStone/S version numbers"
	"Note, #fromString: is implemented in Rowan. Parsing uses #fromComponents:.
	These two methods should return the same answer."

	| parser ast |
	parser := self parser version end.
	ast := parser parse: '3.7.14'.
	self
		assert: ast
		equals: (RwCAQPrimitive value: (RwGemStoneVersionNumber fromString: '3.7.14')).

	ast := parser parse: '3.7.0'.
	self
		assert: ast
		equals: (RwCAQPrimitive value: (RwGemStoneVersionNumber fromString: '3.7')).
]
