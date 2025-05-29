Class {
	#name : 'RwCAQInvalidExpression',
	#superclass : 'RwCAQError',
	#instVars : [
		'expression',
		'result'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQInvalidExpression class >> expression: ast
result: anObject [

	^self new
		expression: ast;
		result: anObject;
		yourself
]

{ #category : 'signaling' }
RwCAQInvalidExpression class >> signalExpression: ast
result: anObject [

	| exception |
	exception := self
		expression: ast
		result: anObject.
	^exception signal
]

{ #category : 'accessing' }
RwCAQInvalidExpression >> expression [
	"Erroneous expression"

	^expression
]

{ #category : 'accessing' }
RwCAQInvalidExpression >> expression: ast [
	"Erroneous expression"

	expression := ast
]

{ #category : 'accessing' }
RwCAQInvalidExpression >> generatedMessageText [

	^String
		streamContents:
			[:stream |
			stream nextPutAll: 'Evaluating `'.
			expression prettyPrintOn: stream.
			stream nextPutAll: '` evaluated to the non-boolean value `'.
			stream print: result.
			stream nextPutAll: '`.'].
]

{ #category : 'accessing' }
RwCAQInvalidExpression >> messageText [

	^messageText ifNil: [self generatedMessageText]
]

{ #category : 'accessing' }
RwCAQInvalidExpression >> result [
	"Result of evaluating the expression"

	^result
]

{ #category : 'accessing' }
RwCAQInvalidExpression >> result: anObject [
	"Result of evaluating the expression"

	result := anObject
]
