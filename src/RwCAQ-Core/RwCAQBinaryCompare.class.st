Class {
	#name : 'RwCAQBinaryCompare',
	#superclass : 'RwCAQAst',
	#instVars : [
		'left',
		'op',
		'right'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQBinaryCompare class >> left: lAst
op: operation
right: rAst [

	^self new
		left: lAst;
		op: operation;
		right: rAst;
		yourself
]

{ #category : 'instance creation' }
RwCAQBinaryCompare class >> methodSelector [
	"method comment"

	| temps |
	^ self yourself
]

{ #category : 'comparing' }
RwCAQBinaryCompare >> = aBinaryCompare [

	^self class == aBinaryCompare class
		and: [left = aBinaryCompare left
				and: [op = aBinaryCompare op
						and: [right = aBinaryCompare right]]]
]

{ #category : 'comparing' }
RwCAQBinaryCompare >> hash [

	^(left hash bitXor: op hash) bitXor: right hash
]

{ #category : 'accessing' }
RwCAQBinaryCompare >> left [

	^left
]

{ #category : 'accessing' }
RwCAQBinaryCompare >> left: astNode [

	left := astNode
]

{ #category : 'accessing' }
RwCAQBinaryCompare >> op [

	^op
]

{ #category : 'accessing' }
RwCAQBinaryCompare >> op: opSelector [

	op := opSelector
]

{ #category : 'printing' }
RwCAQBinaryCompare >> prettyPrintOn: aStream [

	left prettyPrintOn: aStream.
	aStream
		space;
		nextPutAll: op;
		space.
	right prettyPrintOn: aStream
]

{ #category : 'accessing' }
RwCAQBinaryCompare >> right [

	^right
]

{ #category : 'accessing' }
RwCAQBinaryCompare >> right: astNode [

	right := astNode
]

{ #category : 'accessing' }
RwCAQBinaryCompare >> selector [
	"Return the appropriate selector to perform."

	^op
]
