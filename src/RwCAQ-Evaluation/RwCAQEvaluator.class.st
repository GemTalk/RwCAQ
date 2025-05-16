Class {
	#name : 'RwCAQEvaluator',
	#superclass : 'Object',
	#instVars : [
		'context',
		'ast'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQEvaluator class >> context: aContext
ast: rootNode [

	^self new
		context: aContext;
		ast: rootNode;
		yourself
]

{ #category : 'accessing' }
RwCAQEvaluator >> ast [
	"Returns the ast that is to be evaluated."

	^ast
]

{ #category : 'accessing' }
RwCAQEvaluator >> ast: rootNode [
	"Sets the root AST node associated with this evaluation."

	ast := rootNode
]

{ #category : 'accessing' }
RwCAQEvaluator >> context [
	"Returns the RwCAQContext associated with this evaluation."

	^context
]

{ #category : 'accessing' }
RwCAQEvaluator >> context: aContext [
	"Sets the RwCAQContext associated with this evaluation."

	context := aContext
]

{ #category : 'evaluating' }
RwCAQEvaluator >> evaluate [
	"Evaluate the ast, with the provided context."

	| result |
	result := ast evaluateIn: context.
	result class == RwCAQSentinel
		ifTrue: [^false].
	^result
]
