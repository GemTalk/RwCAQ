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

	| ast evaluator result |
	ast := self parse: aString.
	evaluator := RwCAQEvaluator
		context: context
		ast: ast.
	result := evaluator evaluate.
	self
		assert: result
		equals: expected
]

{ #category : 'asserting' }
RwCAQEvaluatorTest >> evaluating: aString
raises: anExceptionClass [

	| ast evaluator result raisedException |
	ast := self parse: aString.
	evaluator := RwCAQEvaluator
		context: context
		ast: ast.
	[evaluator evaluate]
		on: anExceptionClass
		do: [:ex | raisedException := ex. ex return].
	^raisedException ifNil: [self assert: false]
]

{ #category : 'accessing' }
RwCAQEvaluatorTest >> gsVersionString [

	^System gemVersionReport at: 'gsVersion'
]

{ #category : 'parsing' }
RwCAQEvaluatorTest >> parse: aString [

	^RwCAQParser new parse: aString
]

{ #category : 'context management' }
RwCAQEvaluatorTest >> prepareContext [
	"Load all of the implicit variables into context."

	context
		set: 'gemstone'.
	context
		set: 'gemstone.version'
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
		evaluating: '(true)'
		equals: true.
	self
		evaluating: 'false'
		equals: false.
	self
		evaluating: '(false)'
		equals: false
]

{ #category : 'running-erroneous values' }
RwCAQEvaluatorTest >> test_boolean_as_compare_operand [
	"Booleans are not comparable using greater than or less than operators."

	| error |
	error := self
		evaluating: 'true > gemstone'
		raises: RwCAQComparableExpected.
	self
		assert: error messageText
		equals: 'Expected comparable operand after evaluating `true` in `true > gemstone`. Operand was `true`.'.

	error := self
		evaluating: '3.7 > gemstone'
		raises: RwCAQComparableExpected.
	self
		assert: error messageText
		equals: 'Expected comparable operand after evaluating `gemstone` in `3.7 > gemstone`. Operand was `true`.'
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_closed_range [

	context
		set: 'gemstone.version'
		to: '3.7.4' asRwGemStoneVersionNumber.
	self
		evaluating: 'gs3.[0-7]'
		equals: true.
	self
		evaluating: 'gs4.[0-7]'
		equals: false.
	self
		evaluating: 'gs3.7.[0-4]'
		equals: true.
	self
		evaluating: 'gs3.8.[0-4]'
		equals: false.
	self
		evaluating: 'gs3.7.4.[0-5]'
		equals: true.
	self
		evaluating: 'gs3.7.5.[0-10]'
		equals: false
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_closed_range_with_unset_version [

	context
		set: 'gemstone.version'
		to: '3.7.4' asRwGemStoneVersionNumber.
	self
		evaluating: 'gs3.[0-7]'
		equals: true.
	self clearContext.
	self
		evaluating: 'gs3.[0-7]'
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

{ #category : 'running-composed' }
RwCAQEvaluatorTest >> test_compare_and_equality_and_logic [
	"The test writer considered two possible forms for the parsed expression.

	Expected form: (x = y) | z
	Incorrect form: x = (y | z)

	The comparision is treated as the x value, since it requires version
	operands. Boolean operands will cause an error.

	When evaluating x=false, y=false, and z=true, the expected form yields
	a result of true. The incorrect form yields a result of false.

	This is why this particular expression was chosen."

	self
		evaluating: '3.5 < 3.0 = false | true'
		equals: true
]

{ #category : 'running-composed' }
RwCAQEvaluatorTest >> test_compare_and_logic [

	self
		evaluating: 'gemstone.version > 3.0 | true'
		equals: true.
	self
		evaluating: 'gemstone.version > 3.0 | false'
		equals: true.
	self
		evaluating: 'gemstone.version < 3.0 | true'
		equals: true.
	self
		evaluating: 'gemstone.version < 3.0 | false'
		equals: false.
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_compare_with_unset_variable [
	"When a variable isn't set, it should result in
	comparision operations evaluating to false."

	self
		evaluating: 'gemstone.version > 3.0'
		equals: true.
	self
		evaluating: '3.0 <= gemstone.version'
		equals: true.
	self clearContext.
	self
		evaluating: 'gemstone.version > 3.0'
		equals: false.
	self
		evaluating: '3.0 <= gemstone.version'
		equals: false.
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
	self
		evaluating: 'test.version = 3.0 | true'
		equals: true.
	context
		set: 'test.version'
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

{ #category : 'running-composed' }
RwCAQEvaluatorTest >> test_equality_with_ranges [

	context
		set: 'gemstone.version'
		to: '3.7.4' asRwGemStoneVersionNumber.
	self
		evaluating: 'gs3.7.x = true'
		equals: true.
	self
		evaluating: 'gs3.7.x = false'
		equals: false.
	self
		evaluating: 'gs3.7.x = false'
		equals: false.
	self
		evaluating: 'gs3.7.[4-] = true'
		equals: true.
	self
		evaluating: 'gs3.7.[4-] = false'
		equals: false.
	self
		evaluating: 'gs3.7.[0-4] = true'
		equals: true.
	self
		evaluating: 'gs3.7.[0-4] = false'
		equals: false.
	self
		evaluating: 'gs3.7.4.[0-15] = true'
		equals: true.
	self
		evaluating: 'gs3.7.4.[1-15] = true'
		equals: false
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_equality_with_unset_variable [
	"When a variable isn't set, it should result in
	comparision operations evaluating to false
	even if it is being compared to false."

	| left right |
	left := 'gemstone.version = ', (System gemVersionReport at: 'gsVersion').
	right := (System gemVersionReport at: 'gsVersion'), ' = gemstone.version'.
	self
		evaluating: left
		equals: true.
	self
		evaluating: right
		equals: true.
	self clearContext.
	self
		evaluating: left
		equals: false.
	self
		evaluating: right
		equals: false.

	"I believe this is the correct behavior. An unset variable can coerce to false
	in some situations. It isn't true to say that it is false for the purposes of
	an equality check."
	self
		evaluating: 'gemstone.version = false'
		equals: false.
	self
		evaluating: 'false = gemstone.version'
		equals: false.

	"Since this variable is unset, it does not have a value. Therefore, it is not
	equivalent to itself."
	self
		evaluating: 'gemstone.version = gemstone.version'
		equals: false
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_logic_and [

	self
		evaluating: 'true & true'
		equals: true.
	self
		evaluating: '((true) & (true))'
		equals: true.
	self
		evaluating: 'true & false'
		equals: false.
	self
		evaluating: '((true) & (false))'
		equals: false.
	self
		evaluating: 'false & true'
		equals: false.
	self
		evaluating: '((false) & (true))'
		equals: false.
	self
		evaluating: 'false & false'
		equals: false.
	self
		evaluating: '((false) & (false))'
		equals: false
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_logic_or [

	self
		evaluating: 'true | true'
		equals: true.
	self
		evaluating: '((true) | (true))'
		equals: true.
	self
		evaluating: 'true | false'
		equals: true.
	self
		evaluating: '((true) | (false))'
		equals: true.
	self
		evaluating: 'false | true'
		equals: true.
	self
		evaluating: '((false) | (true))'
		equals: true.
	self
		evaluating: 'false | false'
		equals: false.
	self
		evaluating: '((false) | (false))'
		equals: false
]

{ #category : 'running-composed' }
RwCAQEvaluatorTest >> test_logic_with_ranges [

	context
		set: 'gemstone.version'
		to: '3.7.4' asRwGemStoneVersionNumber.
	self
		evaluating: 'gs3.7.x & true'
		equals: true.
	self
		evaluating: 'gs3.7.x & false'
		equals: false.
	self
		evaluating: 'gs3.7.x | false'
		equals: true.
	self
		evaluating: 'gs3.7.[4-] & true'
		equals: true.
	self
		evaluating: 'gs3.7.[4-] & false'
		equals: false.
	self
		evaluating: 'gs3.7.[0-4] & true'
		equals: true.
	self
		evaluating: 'gs3.7.[0-4] & false'
		equals: false.
	self
		evaluating: 'gs3.7.4.[0-15] & true'
		equals: true.
	self
		evaluating: 'gs3.7.4.[1-15] & true'
		equals: false
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_logic_with_unset_variable [
	"When a variable isn't set, it should act as a false
	in a logic statement."

	self
		evaluating: 'pharo | false'
		equals: false.
	self
		evaluating: 'pharo | true'
		equals: true.
	self
		evaluating: 'false | pharo'
		equals: false.
	self
		evaluating: 'true | pharo'
		equals: true.
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_open_range [

	context
		set: 'gemstone.version'
		to: '3.7.4' asRwGemStoneVersionNumber.
	self
		evaluating: 'gs3.[0-]'
		equals: true.
	self
		evaluating: 'gs4.[0-]'
		equals: false.
	self
		evaluating: 'gs3.7.[0-]'
		equals: true.
	self
		evaluating: 'gs3.8.[0-]'
		equals: false.
	self
		evaluating: 'gs3.7.4.[0-]'
		equals: true.
	self
		evaluating: 'gs3.7.5.[0-]'
		equals: false
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_open_range_with_unset_version [

	context
		set: 'gemstone.version'
		to: '3.7.4' asRwGemStoneVersionNumber.
	self
		evaluating: 'gs3.[0-]'
		equals: true.
	self clearContext.
	self
		evaluating: 'gs3.[0-]'
		equals: false
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_operands_wrapped_in_parens [

	self
		evaluating: '(true) & (true)'
		equals: true.
	self
		evaluating: '(false) & (true)'
		equals: false.
	self
		evaluating: '(true) = (true)'
		equals: true.
	self
		evaluating: '(true) = (false)'
		equals: false.
	self
		evaluating: '(3.7.5) > (3.0)'
		equals: true.
	context
		set: 'gemstone.version'
		to: '3.7.4' asRwGemStoneVersionNumber.
	self
		evaluating: '(3.7.5) > (gemstone.version)'
		equals: true
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_parens_allow_unlimited_nesting [

	self
		evaluating: '((((((true))))))'
		equals: true
]

{ #category : 'running-composed' }
RwCAQEvaluatorTest >> test_parens_change_equality_ordering [

	self
		evaluating: '3.5 = 3.5 = true'
		equals: true.
	self
		evaluating: '(3.5 = 3.5) = true'
		equals: true.
	self
		evaluating: '3.5 = (3.5 = true)'
		equals: false.
]

{ #category : 'running-composed' }
RwCAQEvaluatorTest >> test_parens_change_evaluating_of_equality_and_logic [
	"Based on test_compare_and_equality_and_logic.

	The test writer considered two possible forms for the parsed expression.

	Form A: (x = y) | z
	Form B: x = (y | z)

	The comparision is treated as the x value, since it requires version
	operands. Boolean operands will cause an error.

	When evaluating x=false, y=false, and z=true,  Form A yields true.
	Form B yields false.

	This is why this particular expression was chosen."

	self
		evaluating: '(3.5 < 3.0 = false) | true'
		equals: true.
	self
		evaluating: '3.5 < 3.0 = (false | true)'
		equals: false
]

{ #category : 'running-composed' }
RwCAQEvaluatorTest >> test_parens_change_logic_ordering [

	self
		evaluating: 'true | true & false'
		equals: false.
	self
		evaluating: '(true | true) & false'
		equals: false.
	self
		evaluating: 'true | (true & false)'
		equals: true.
]

{ #category : 'running-erroneous values' }
RwCAQEvaluatorTest >> test_range_as_compare_operand [
	"Ranges evaluate to boolean values. They are not comparable using greater than or less than operators."

	| error |
	error := self
		evaluating: 'gs2.7.x > gemstone.version'
		raises: RwCAQComparableExpected.
	self
		assert: error messageText
		equals: 'Expected comparable operand after evaluating `gs2.7.x` in `gs2.7.x > gemstone.version`. Operand was `false`.'.

	error := self
		evaluating: 'gs2.7.[2-] > gemstone.version'
		raises: RwCAQComparableExpected.
	self
		assert: error messageText
		equals: 'Expected comparable operand after evaluating `gs2.7.[2-]` in `gs2.7.[2-] > gemstone.version`. Operand was `false`.'.

	error := self
		evaluating: 'gs2.7.[2-4] > gemstone.version'
		raises: RwCAQComparableExpected.
	self
		assert: error messageText
		equals: 'Expected comparable operand after evaluating `gs2.7.[2-4]` in `gs2.7.[2-4] > gemstone.version`. Operand was `false`.'
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_ranges_use_gemstone_version_from_context [

	self
		evaluating: 'gs2.7.x'
		equals: false.
	self
		evaluating: 'gs2.7.[3-]'
		equals: false.
	self
		evaluating: 'gs2.7.[3-4]'
		equals: false.

	context
		set: 'gemstone.version'
		to: '2.7.4' asRwGemStoneVersionNumber.

	self
		evaluating: 'gs2.7.x'
		equals: true.
	self
		evaluating: 'gs2.7.[3-]'
		equals: true.
	self
		evaluating: 'gs2.7.[3-4]'
		equals: true.
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_ranges_with_parens [

	self clearContext.
	self
		evaluating: 'gs3.7.[4-]'
		equals: false.
	self
		evaluating: '(gs3.7.[4-])'
		equals: false.
	self
		evaluating: 'gs3.7.[4-9]'
		equals: false.
	self
		evaluating: '(gs3.7.[4-9])'
		equals: false.
	self
		evaluating: 'gs3.7.x'
		equals: false.
	self
		evaluating: '(gs3.7.x)'
		equals: false.
	context
		set: 'gemstone.version'
		to: '3.7.4' asRwGemStoneVersionNumber.
	self
		evaluating: 'gs3.7.[4-]'
		equals: true.
	self
		evaluating: '(gs3.7.[4-])'
		equals: true.
	self
		evaluating: 'gs3.7.[4-9]'
		equals: true.
	self
		evaluating: '(gs3.7.[4-9])'
		equals: true.
	self
		evaluating: 'gs3.7.x'
		equals: true.
	self
		evaluating: '(gs3.7.x)'
		equals: true.
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_subversion_range [

	context
		set: 'gemstone.version'
		to: '3.7.4' asRwGemStoneVersionNumber.
	self
		evaluating: 'gs3.7.x'
		equals: true.
	self
		evaluating: 'gs3.6.x'
		equals: false.
	self
		evaluating: 'gs3.8.x'
		equals: false.
	self
		evaluating: 'gs3.7.4.x'
		equals: true.
	self
		evaluating: 'gs3.x'
		equals: true.
	self
		evaluating: 'gs2.x'
		equals: false
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_subversion_range_with_unset_version [

	context
		set: 'gemstone.version'
		to: '3.7.4' asRwGemStoneVersionNumber.
	self
		evaluating: 'gs3.7.x'
		equals: true.
	self clearContext.
	self
		evaluating: 'gs3.7.x'
		equals: false
]

{ #category : 'running-trivial' }
RwCAQEvaluatorTest >> test_variable [

	self clearContext.
	self
		evaluating: 'gemstone'
		equals: false.
	self
		evaluating: '(gemstone)'
		equals: false.
	context set: 'gemstone'.
	self
		evaluating: 'gemstone'
		equals: true.
	self
		evaluating: '(gemstone)'
		equals: true.
	self
		evaluating: 'pharo'
		equals: false.
	self
		evaluating: '(pharo)'
		equals: false
]

{ #category : 'running-simple' }
RwCAQEvaluatorTest >> test_variables_use_gemstone_version_from_context [

	self
		evaluating: 'gemstone.version = ', self gsVersionString
		equals: true.
	self
		evaluating: 'gemstone.version = 2.7.4'
		equals: false.

	context
		set: 'gemstone.version'
		to: '2.7.4' asRwGemStoneVersionNumber.

	self
		evaluating: 'gemstone.version = ', self gsVersionString
		equals: false.
	self
		evaluating: 'gemstone.version = 2.7.4'
		equals: true
]

{ #category : 'running-erroneous values' }
RwCAQEvaluatorTest >> test_version_as_logic_operand [
	"Versions are not comparable logical operands."

	| error |
	error := self
		evaluating: 'gemstone.version | 3.6.0'
		raises: RwCAQBooleanExpected.
	self
		assert: error messageText
		equals: 'Expected boolean operand after evaluating `gemstone.version` in `gemstone.version | 3.6.0`. Operand was `3.7.4`.'.

	error := self
		evaluating: 'true | 3.6.0'
		raises: RwCAQBooleanExpected.
	self
		assert: error messageText
		equals: 'Expected boolean operand after evaluating `3.6.0` in `true | 3.6.0`. Operand was `3.6.0`.'.
]
