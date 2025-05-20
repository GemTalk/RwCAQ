Class {
	#name : 'RwCAQInvalidOperand',
	#superclass : 'RwCAQError',
	#instVars : [
		'expression',
		'subexpression',
		'operand'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQInvalidOperand class >> expression: expression
subexpression: subexpression
operand: value [

	^self new
		expression: expression;
		subexpression: subexpression;
		operand: value;
		yourself
]

{ #category : 'signaling' }
RwCAQInvalidOperand class >> signalExpression: expression
subexpression: subexpression
operand: value [

	^(self
		expression: expression
		subexpression: subexpression
		operand: value)
		signal
]

{ #category : 'accessing' }
RwCAQInvalidOperand >> expression [
	"Expression containing invalid operand"

	^expression
]

{ #category : 'accessing' }
RwCAQInvalidOperand >> expression: anAST [

	expression := anAST
]

{ #category : 'accessing' }
RwCAQInvalidOperand >> operand [
	"Object which is invalid as an operand."

	^operand
]

{ #category : 'accessing' }
RwCAQInvalidOperand >> operand: anObject [

	operand := anObject
]

{ #category : 'accessing' }
RwCAQInvalidOperand >> subexpression [
	"The subexpression evaluating to an invalid operand"

	^subexpression
]

{ #category : 'accessing' }
RwCAQInvalidOperand >> subexpression: anAST [

	subexpression := anAST
]
