Class {
	#name : 'RwCAQBinaryOperation',
	#superclass : 'RwCAQAst',
	#instVars : [
		'left',
		'op',
		'right'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQBinaryOperation class >> left: lAst
op: operation
right: rAst [

	^self new
		left: lAst;
		op: operation;
		right: rAst;
		yourself
]

{ #category : 'comparing' }
RwCAQBinaryOperation >> = aBinaryOperation [

	^self class == aBinaryOperation class
		and: [left = aBinaryOperation left
				and: [op = aBinaryOperation op
						and: [right = aBinaryOperation right]]]
]

{ #category : 'comparing' }
RwCAQBinaryOperation >> hash [

	^(left hash bitXor: op hash) bitXor: right hash
]

{ #category : 'accessing' }
RwCAQBinaryOperation >> left [

	^left
]

{ #category : 'accessing' }
RwCAQBinaryOperation >> left: astNode [

	left := astNode
]

{ #category : 'accessing' }
RwCAQBinaryOperation >> op [

	^op
]

{ #category : 'accessing' }
RwCAQBinaryOperation >> op: opSelector [

	op := opSelector
]

{ #category : 'printing' }
RwCAQBinaryOperation >> prettyPrintOn: aStream [

	left prettyPrintOn: aStream.
	aStream
		space;
		nextPutAll: op;
		space.
	right prettyPrintOn: aStream
]

{ #category : 'accessing' }
RwCAQBinaryOperation >> right [

	^right
]

{ #category : 'accessing' }
RwCAQBinaryOperation >> right: astNode [

	right := astNode
]

{ #category : 'accessing' }
RwCAQBinaryOperation >> selector [
	"Return the appropriate selector to perform."

	^op
]
