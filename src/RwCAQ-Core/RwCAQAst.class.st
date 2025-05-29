Class {
	#name : 'RwCAQAst',
	#superclass : 'Object',
	#category : 'RwCAQ-Core'
}

{ #category : 'wrapping' }
RwCAQAst >> parens [
	"Wrap this AST Node with parenthesis."

	^RwCAQParenthesis expression: self
]

{ #category : 'printing' }
RwCAQAst >> prettyPrintOn: aStream [

	self subclassResponsibility
]

{ #category : 'printing' }
RwCAQAst >> printOn: aStream [

	self prettyPrintOn: aStream
]
