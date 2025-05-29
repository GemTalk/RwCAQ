Class {
	#name : 'RwCAQParenthesis',
	#superclass : 'RwCAQAst',
	#instVars : [
		'expression'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQParenthesis class >> expression: expression [

	^self new
		expression: expression;
		yourself
]

{ #category : 'comparing' }
RwCAQParenthesis >> = aNode [

	^self class == aNode class
		and: [expression = aNode expression]
]

{ #category : 'accessing' }
RwCAQParenthesis >> expression [
	"The wrapped expression"

	^expression
]

{ #category : 'accessing' }
RwCAQParenthesis >> expression: astNode [
	"The wrapped expression"

	expression := astNode
]

{ #category : 'comparing' }
RwCAQParenthesis >> hash [

	^expression hash
]

{ #category : 'printing' }
RwCAQParenthesis >> prettyPrintOn: aStream [

	aStream nextPut: $(.
	expression prettyPrintOn: aStream.
	aStream nextPutAll: $)
]
