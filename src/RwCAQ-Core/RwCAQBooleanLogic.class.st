Class {
	#name : 'RwCAQBooleanLogic',
	#superclass : 'RwCAQAst',
	#instVars : [
		'left',
		'op',
		'right'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQBooleanLogic class >> left: lAst
op: operation
right: rAst [

	^self new
		left: lAst;
		op: operation;
		right: rAst;
		yourself
]

{ #category : 'instance creation' }
RwCAQBooleanLogic class >> methodSelector [
	"method comment"

	| temps |
	^ self yourself
]

{ #category : 'comparing' }
RwCAQBooleanLogic >> = aBooleanLogic [

	^self class == aBooleanLogic class
		and: [left = aBooleanLogic left
				and: [op = aBooleanLogic op
						and: [right = aBooleanLogic right]]]
]

{ #category : 'comparing' }
RwCAQBooleanLogic >> hash [

	^(left hash bitXor: op hash) bitXor: right hash
]

{ #category : 'accessing' }
RwCAQBooleanLogic >> left [

	^left
]

{ #category : 'accessing' }
RwCAQBooleanLogic >> left: astNode [

	left := astNode
]

{ #category : 'accessing' }
RwCAQBooleanLogic >> op [

	^op
]

{ #category : 'accessing' }
RwCAQBooleanLogic >> op: opSelector [

	op := opSelector
]

{ #category : 'printing' }
RwCAQBooleanLogic >> prettyPrintOn: aStream [

	left prettyPrintOn: aStream.
	aStream space.
	aStream nextPutAll: op.
	aStream space.
	right prettyPrintOn: aStream
]

{ #category : 'printing' }
RwCAQBooleanLogic >> printOn: aStream [

	self prettyPrintOn: aStream
]

{ #category : 'accessing' }
RwCAQBooleanLogic >> right [

	^right
]

{ #category : 'accessing' }
RwCAQBooleanLogic >> right: astNode [

	right := astNode
]
