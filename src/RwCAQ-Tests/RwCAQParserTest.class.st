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

{ #category : 'testing-trivial' }
RwCAQParserTest >> test_boolean [
	"Parse false"

	self
		parsing: 'true'
		equals: (RwCAQValue value: true).
	self
		parsing: 'truex'
		equals: (RwCAQVariable name: #'truex').
	self
		parsing: 'false'
		equals: (RwCAQValue value: false).
	self
		parsing: 'falsex'
		equals: (RwCAQVariable name: #'falsex').
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_compare [
	"Parse an equality statement"

	| expected |
	expected := RwCAQBinaryCompare
		left: (RwCAQVariable name: #'gemstone.version')
		op: #>
		right: (RwCAQValue value: '42' asRwGemStoneVersionNumber).
	self
		parsing: 'gemstone.version > 42'
		equals: expected.
	expected op: #>=.
	self
		parsing: 'gemstone.version >= 42'
		equals: expected.
	expected op: #<=.
	self
		parsing: 'gemstone.version <= 42'
		equals: expected.
	expected op: #<.
	self
		parsing: 'gemstone.version < 42'
		equals: expected.
]

{ #category : 'testing-composed' }
RwCAQParserTest >> test_compare_and_equality [

	| compare trueNode equality |
	compare := RwCAQBinaryCompare
		left: (RwCAQVariable name: #'gemstone.version')
		op: #'>='
		right: (RwCAQValue value: '3.0' asRwGemStoneVersionNumber).
	trueNode := RwCAQValue value: true.
	equality := RwCAQEquality
		left: compare
		right: trueNode.
	self
		parsing: 'gemstone.version >= 3.0 = true'
		equals: equality.
	
	equality := RwCAQEquality
		left: trueNode
		right: compare.
	self
		parsing: 'true = gemstone.version >= 3.0'
		equals: equality
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_equality [
	"Parse an equality statement"

	| expected |
	expected := RwCAQEquality
		left: (RwCAQVariable name: #'gemstone.version')
		right: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '42')).
	self
		parsing: 'gemstone.version = 42'
		equals: expected.
	expected := RwCAQEquality
		left: (RwCAQVariable name: #'tests')
		right: (RwCAQValue value: true).
	self
		parsing: 'tests = true'
		equals: expected
]

{ #category : 'testing-composed' }
RwCAQParserTest >> test_equality_and_logic [

	| equality trueNode logic |
	equality := RwCAQEquality
		left: (RwCAQVariable name: #'gemstone.version')
		right: (RwCAQValue value: '3.0' asRwGemStoneVersionNumber).
	trueNode := RwCAQValue value: true.
	logic := RwCAQBooleanLogic
		left: equality
		op: #'|'
		right: trueNode.
	self
		parsing: 'gemstone.version = 3.0 | true'
		equals: logic.
	
	logic := RwCAQBooleanLogic
		left: trueNode
		op: #'|'
		right: equality.
	self
		parsing: 'true | gemstone.version = 3.0'
		equals: logic
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_equality_is_left_associative [

	| expected left |
	left := RwCAQEquality
		left: (RwCAQValue value: true)
		right: (RwCAQValue value: false).
	expected := RwCAQEquality
		left: left
		right: (RwCAQValue value: true).
	self
		parsing: 'true = false = true'
		equals: expected
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_equality_variable_spacing [
	"Parse an equality statement"

	| expected |
	expected := RwCAQEquality
		left: (RwCAQVariable name: #'gemstone.version')
		right: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '42')).
	self
		parsing: 'gemstone.version          =42'
		equals: expected.
	self
		parsing: 'gemstone.version=         42'
		equals: expected
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_logic [
	"Parse a logic statement"

	| expected |
	expected := RwCAQBooleanLogic
		left: (RwCAQVariable name: #'gemstone')
		op: #|
		right: (RwCAQValue value: true).
	self
		parsing: 'gemstone | true'
		equals: expected.
]

{ #category : 'testing-trivial' }
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

{ #category : 'testing-trivial' }
RwCAQParserTest >> test_version [
	"GemStone/S version numbers"
	"Note, #fromString: is implemented in Rowan. Parsing uses #fromComponents:.
	These two methods should return the same answer."

	| parser ast |
	parser := self parser version end.
	ast := parser parse: '3.7.14'.
	self
		assert: ast
		equals: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '3.7.14')).

	ast := parser parse: '3.7.0'.
	self
		assert: ast
		equals: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '3.7')).

	ast := parser parse: '3'.
	self
		assert: ast
		equals: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '3')).
]
