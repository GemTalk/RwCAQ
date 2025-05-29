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

{ #category : 'testing-simple' }
RwCAQParserTest >> test_boolean [
	"Parse false"

	self
		parsing: 'true'
		equals: (RwCAQValue value: true).
	self
		parsing: 'truex'
		equals: (RwCAQVariable name: 'truex').
	self
		parsing: 'false'
		equals: (RwCAQValue value: false).
	self
		parsing: 'falsex'
		equals: (RwCAQVariable name: 'falsex').
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_boolean_with_parens [
	"Parse false"

	self
		parsing: '(true)'
		equals: (RwCAQValue value: true) parens.
	self
		parsing: '(false)'
		equals: (RwCAQValue value: false) parens
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_closed_range [

	| expected |
	expected := RwCAQClosedRange
		min: '3.1' asRwGemStoneVersionNumber
		max: '3.10' asRwGemStoneVersionNumber.
	self
		parsing: 'gs3.[1-9]'
		equals: expected.

	expected := RwCAQClosedRange
		min: '3.5.7' asRwGemStoneVersionNumber
		max: '3.5.9' asRwGemStoneVersionNumber.
	self
		parsing: 'gs3.5.[7-8]'
		equals: expected
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_closed_range_with_parens [

	| range expected |
	range := RwCAQClosedRange
		min: '3.1' asRwGemStoneVersionNumber
		max: '3.10' asRwGemStoneVersionNumber.
	expected := range parens.
	self
		parsing: '(gs3.[1-9])'
		equals: expected.

	range := RwCAQClosedRange
		min: '3.5.7' asRwGemStoneVersionNumber
		max: '3.5.9' asRwGemStoneVersionNumber.
	expected := range parens.
	self
		parsing: '(gs3.5.[7-8])'
		equals: expected
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_compare [
	"Parse an equality statement"

	| expected |
	expected := RwCAQCompare
		left: (RwCAQVariable name: 'gemstone.version')
		op:'>'
		right: (RwCAQValue value: '42' asRwGemStoneVersionNumber).
	self
		parsing: 'gemstone.version > 42'
		equals: expected.
	expected op: '>='.
	self
		parsing: 'gemstone.version >= 42'
		equals: expected.
	expected op: '<='.
	self
		parsing: 'gemstone.version <= 42'
		equals: expected.
	expected op: '<'.
	self
		parsing: 'gemstone.version < 42'
		equals: expected.
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_compare_and_equality [

	| compare trueNode equality |
	compare := RwCAQCompare
		left: (RwCAQVariable name: 'gemstone.version')
		op: '>='
		right: (RwCAQValue value: '3.0' asRwGemStoneVersionNumber).
	trueNode := RwCAQValue value: true.
	equality := RwCAQEquality
		left: compare
		op: '='
		right: trueNode.
	self
		parsing: 'gemstone.version >= 3.0 = true'
		equals: equality.
	
	equality := RwCAQEquality
		left: trueNode
		op: '='
		right: compare.
	self
		parsing: 'true = gemstone.version >= 3.0'
		equals: equality
]

{ #category : 'testing-composed' }
RwCAQParserTest >> test_compare_and_equality_and_logic [

	| compare trueNode equality tests logic |
	compare := RwCAQCompare
		left: (RwCAQVariable name: 'gemstone.version')
		op: '>='
		right: (RwCAQValue value: '3.0' asRwGemStoneVersionNumber).
	trueNode := RwCAQValue value: true.
	equality := RwCAQEquality
		left: compare
		op: '='
		right: trueNode.
	tests := RwCAQVariable name: 'tests'.
	logic := RwCAQLogic
		left: equality
		op: '|'
		right: tests.
	self
		parsing: 'gemstone.version >= 3.0 = true | tests'
		equals: logic.

	equality := RwCAQEquality
		left: trueNode
		op: '='
		right: compare.
	logic := RwCAQLogic
		left: tests
		op: '|'
		right: equality.
	self
		parsing: 'tests | true = gemstone.version >= 3.0'
		equals: logic
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_compare_and_equality_with_parens [

	| compare trueNode equality |
	compare := RwCAQCompare
		left: (RwCAQVariable name: 'gemstone.version')
		op: '>='
		right: (RwCAQValue value: '3.0' asRwGemStoneVersionNumber).
	trueNode := RwCAQValue value: true.
	equality := RwCAQEquality
		left: compare
		op: '='
		right: trueNode.
	self
		parsing: '(gemstone.version >= 3.0 = true)'
		equals: equality parens.
	
	equality := RwCAQEquality
		left: trueNode
		op: '='
		right: compare.
	self
		parsing: '(true = gemstone.version >= 3.0)'
		equals: equality parens
]

{ #category : 'testing-composed' }
RwCAQParserTest >> test_compare_and_logic [

	| compare trueNode logic |
	compare := RwCAQCompare
		left: (RwCAQVariable name: 'gemstone.version')
		op: '>='
		right: (RwCAQValue value: '3.0' asRwGemStoneVersionNumber).
	trueNode := RwCAQValue value: true.
	logic := RwCAQLogic
		left: compare
		op: '|'
		right: trueNode.
	self
		parsing: 'gemstone.version >= 3.0 | true'
		equals: logic.
	
	logic := RwCAQLogic
		left: trueNode
		op: '|'
		right: compare.
	self
		parsing: 'true | gemstone.version >= 3.0'
		equals: logic
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_compare_with_parens [
	"Parse an equality statement"

	| expected |
	expected := RwCAQCompare
		left: (RwCAQVariable name: 'gemstone.version')
		op:'>'
		right: (RwCAQValue value: '42' asRwGemStoneVersionNumber).
	self
		parsing: '(gemstone.version > 42)'
		equals: expected parens.
	expected op: '>='.
	self
		parsing: '(gemstone.version >= 42)'
		equals: expected parens.
	expected op: '<='.
	self
		parsing: '(gemstone.version <= 42)'
		equals: expected parens.
	expected op: '<'.
	self
		parsing: '(gemstone.version < 42)'
		equals: expected parens.
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_equality [
	"Parse an equality statement"

	| expected |
	expected := RwCAQEquality
		left: (RwCAQVariable name: 'gemstone.version')
		op: '='
		right: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '42')).
	self
		parsing: 'gemstone.version = 42'
		equals: expected.

	expected := RwCAQEquality
		left: (RwCAQVariable name: 'tests')
		op: '='
		right: (RwCAQValue value: true).
	self
		parsing: 'tests = true'
		equals: expected
]

{ #category : 'testing-composed' }
RwCAQParserTest >> test_equality_and_logic [

	| equality trueNode logic |
	equality := RwCAQEquality
		left: (RwCAQVariable name: 'gemstone.version')
		op: '='
		right: (RwCAQValue value: '3.0' asRwGemStoneVersionNumber).
	trueNode := RwCAQValue value: true.
	logic := RwCAQLogic
		left: equality
		op: '|'
		right: trueNode.
	self
		parsing: 'gemstone.version = 3.0 | true'
		equals: logic.
	
	logic := RwCAQLogic
		left: trueNode
		op: '|'
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
		op: '='
		right: (RwCAQValue value: false).
	expected := RwCAQEquality
		left: left
		op: '='
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
		left: (RwCAQVariable name: 'gemstone.version')
		op: '='
		right: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '42')).
	self
		parsing: 'gemstone.version          =42'
		equals: expected.
	self
		parsing: 'gemstone.version=         42'
		equals: expected
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_equality_with_parens [
	"Parse an equality statement"

	| expected |
	expected := RwCAQEquality
		left: (RwCAQVariable name: 'gemstone.version')
		op: '='
		right: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '42')).
	self
		parsing: '(gemstone.version = 42)'
		equals: expected parens.

	expected := RwCAQEquality
		left: (RwCAQVariable name: 'tests')
		op: '='
		right: (RwCAQValue value: true).
	self
		parsing: '(tests = true)'
		equals: expected parens
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_logic [
	"Parse a logic statement"

	| gemstone trueNode or and |
	gemstone := RwCAQVariable name: 'gemstone'.
	trueNode := RwCAQValue value: true.
	or := RwCAQLogic
		left: gemstone
		op: '|'
		right: trueNode.
	self
		parsing: 'gemstone | true'
		equals: or.

	and := RwCAQLogic
		left: gemstone
		op: '&'
		right: trueNode.
	self
		parsing: 'gemstone & true'
		equals: and.
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_logic_with_parens [
	"Parse a logic statement"

	| gemstone trueNode or and |
	gemstone := RwCAQVariable name: 'gemstone'.
	trueNode := RwCAQValue value: true.
	or := RwCAQLogic
		left: gemstone
		op: '|'
		right: trueNode.
	self
		parsing: '(gemstone | true)'
		equals: or parens.

	and := RwCAQLogic
		left: gemstone parens
		op: '&'
		right: trueNode.
	self
		parsing: '(gemstone) & true'
		equals: and.
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_open_range [

	| expected |
	expected := RwCAQOpenRange
		min: '3.1' asRwGemStoneVersionNumber
		max: '4' asRwGemStoneVersionNumber.
	self
		parsing: 'gs3.[1-]'
		equals: expected.

	expected := RwCAQOpenRange
		min: '3.5.7' asRwGemStoneVersionNumber
		max: '3.6' asRwGemStoneVersionNumber.
	self
		parsing: 'gs3.5.[7-]'
		equals: expected
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_open_range_with_parens [

	| range parens |
	range := RwCAQOpenRange
		min: '3.1' asRwGemStoneVersionNumber
		max: '4' asRwGemStoneVersionNumber.
	parens := range parens.
	self
		parsing: '(gs3.[1-])'
		equals: parens.

	range := RwCAQOpenRange
		min: '3.5.7' asRwGemStoneVersionNumber
		max: '3.6' asRwGemStoneVersionNumber.
	parens := range parens.
	self
		parsing: '(gs3.5.[7-])'
		equals: parens
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_paren_spacing_is_unimportant [
	"Parse an equality statement"

	| equality parens |
	equality := RwCAQEquality
		left: (RwCAQVariable name: 'gemstone.version')
		op: '='
		right: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '42')).
	parens := equality parens.
	self
		parsing: '(      gemstone.version          =42)'
		equals: parens.
	self
		parsing: '(gemstone.version=         42                     )'
		equals: parens
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_parens_change_equality_associativity [

	| expected right parens |
	right := RwCAQEquality
		left: (RwCAQValue value: false)
		op: '='
		right: (RwCAQValue value: true).
	parens := right parens.
	expected := RwCAQEquality
		left: (RwCAQValue value: true)
		op: '='
		right: parens.
	self
		parsing: 'true = (false = true)'
		equals: expected
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_subversion_range [

	| expected |
	expected := RwCAQSubversionRange
		min: '3' asRwGemStoneVersionNumber
		max: '4' asRwGemStoneVersionNumber.
	self
		parsing: 'gs3.x'
		equals: expected.

	expected := RwCAQSubversionRange
		min: '2.5' asRwGemStoneVersionNumber
		max: '2.6' asRwGemStoneVersionNumber.
	self
		parsing: 'gs2.5.x'
		equals: expected
]

{ #category : 'testing-simple' }
RwCAQParserTest >> test_subversion_range_with_parens [

	| range parens |
	range := RwCAQSubversionRange
		min: '3' asRwGemStoneVersionNumber
		max: '4' asRwGemStoneVersionNumber.
	parens := range parens.
	self
		parsing: '(gs3.x)'
		equals: parens.

	range := RwCAQSubversionRange
		min: '2.5' asRwGemStoneVersionNumber
		max: '2.6' asRwGemStoneVersionNumber.
	parens := range parens.
	self
		parsing: '(gs2.5.x)'
		equals: parens
]

{ #category : 'testing-trivial' }
RwCAQParserTest >> test_variable [
	"Parse solo identifiers"

	|  ast expected |
	ast := self parse: 't'.
	expected := RwCAQVariable name: 't'.
	self
		assert: ast
		equals: expected.
	ast := self parse: 't '.
	expected := RwCAQVariable name: 't'.
	self
		assert: ast
		equals: expected.

	ast := self parse: 'tests'.
	expected := RwCAQVariable name: 'tests'.
	self
		assert: ast
		equals: expected.

	ast := self parse: 'tests.smoke1'.
	expected := RwCAQVariable name: 'tests.smoke1'.
	self
		assert: ast
		equals: expected.

	ast := self parse: 'tests1.smoke.regression'.
	expected := RwCAQVariable name: 'tests1.smoke.regression'.
	self
		assert: ast
		equals: expected.

	ast := self parse: 'tests1....smoke.regression'.
	expected := RwCAQVariable name: 'tests1....smoke.regression'.
	self
		assert: ast
		equals: expected.
]

{ #category : 'testing-trivial' }
RwCAQParserTest >> test_variable_with_parens [
	"Parse solo identifiers"

	| variable parens |
	variable := RwCAQVariable name: 'gemstone'.
	parens := variable parens.
	self
		parsing: '(gemstone)'
		equals: parens.

	variable := RwCAQVariable name: 'gemstone.version'.
	parens := variable parens.
	self
		parsing: '(gemstone.version)'
		equals: parens
]

{ #category : 'testing-trivial' }
RwCAQParserTest >> test_version [
	"GemStone/S version numbers"
	"Note, #fromString: is implemented in Rowan. Parsing uses #fromComponents:.
	These two methods should return the same answer."

	self
		parsing: '3.7.14'
		equals: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '3.7.14')).

	self
		parsing: '3.7'
		equals: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '3.7')).

	self
		parsing: '3'
		equals: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '3')).
]

{ #category : 'testing-trivial' }
RwCAQParserTest >> test_version_with_parens [
	"GemStone/S version numbers"
	"Note, #fromString: is implemented in Rowan. Parsing uses #fromComponents:.
	These two methods should return the same answer."

	self
		parsing: '(3.7.14)'
		equals: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '3.7.14')) parens.

	self
		parsing: '(3.7)'
		equals: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '3.7')) parens.

	self
		parsing: '(3)'
		equals: (RwCAQValue value: (RwGemStoneVersionNumber fromString: '3')) parens.
]
