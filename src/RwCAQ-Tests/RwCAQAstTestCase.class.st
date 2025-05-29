Class {
	#name : 'RwCAQAstTestCase',
	#superclass : 'TestCase',
	#category : 'RwCAQ-Core'
}

{ #category : 'asserting' }
RwCAQAstTestCase >> prettyPrinting: aString
equals: expected [

	| ast result |
	ast := RwCAQParser new parse: expected.
	result := String streamContents: [:stream | ast prettyPrintOn: stream].
	self
		assert: result
		equals: expected
]

{ #category : 'running_pretty_printing' }
RwCAQAstTestCase >> test_pretty_print_closed_range [

	self
		prettyPrinting: ' gs3.[5-9]       '
		equals: 'gs3.[5-9]'
]

{ #category : 'running_pretty_printing' }
RwCAQAstTestCase >> test_pretty_print_compare [

	self
		prettyPrinting: '42>gemstone.version'
		equals: '42 > gemstone.version'.
	self
		prettyPrinting: '42                      >=       gemstone.version'
		equals: '42 >= gemstone.version'
]

{ #category : 'running_pretty_printing' }
RwCAQAstTestCase >> test_pretty_print_equality [

	self
		prettyPrinting: '42=   gemstone.version'
		equals: '42 = gemstone.version'.
	self
		prettyPrinting: 'true   =42=       gemstone.version'
		equals: 'true = 4 = gemstone.version'
]

{ #category : 'running_pretty_printing' }
RwCAQAstTestCase >> test_pretty_print_logic [

	self
		prettyPrinting: 'gemstone|false'
		equals: 'gemstone | false'.
	self
		prettyPrinting: 'false                      &       gemstone'
		equals: 'false & gemstone'
]

{ #category : 'running_pretty_printing' }
RwCAQAstTestCase >> test_pretty_print_open_range [

	self
		prettyPrinting: ' gs3.[5-]       '
		equals: 'gs3.[5-]'
]

{ #category : 'running_pretty_printing' }
RwCAQAstTestCase >> test_pretty_print_parens [

	self
		prettyPrinting: '(( 42) = ((gemstone.version)      ) )'
		equals: '((42) = ((gemstone.version)))'.
	self
		prettyPrinting: '((((42)))                      >=       gemstone.version     )'
		equals: '((((42))) >= gemstone.version)'
]

{ #category : 'running_pretty_printing' }
RwCAQAstTestCase >> test_pretty_print_subversion_range [

	self
		prettyPrinting: ' gs3.x       '
		equals: 'gs3.x'.
	self
		prettyPrinting: ' gs3.5.x       '
		equals: 'gs3.5.x'
]
