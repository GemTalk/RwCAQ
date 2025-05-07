Class {
	#name : 'RwCAQEquality',
	#superclass : 'RwCAQAst',
	#instVars : [
		'left',
		'right'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQEquality class >> left: leftNode
right: rightNode [

	^self new
		left: leftNode;
		right: rightNode;
		yourself
]

{ #category : 'comparing' }
RwCAQEquality >> = anEqualityNode [
	"Compare against another equality node."

	self class == anEqualityNode class
		ifFalse: [^false].
	^self left = anEqualityNode left and: [self right = anEqualityNode right]
]

{ #category : 'comparing' }
RwCAQEquality >> hash [

	^self left hash
		bitXor: self right hash
]

{ #category : 'accessing' }
RwCAQEquality >> left [
	"AST Node representing the value before the equals sign"

	^left
]

{ #category : 'accessing' }
RwCAQEquality >> left: astNode [
	"AST Node representing the value before the equals sign"

	left := astNode
]

{ #category : 'accessing' }
RwCAQEquality >> right [
	"AST Node representing the value after the equals sign"

	^right
]

{ #category : 'accessing' }
RwCAQEquality >> right: astNode [
	"AST Node representing the value after the equals sign"

	right := astNode
]
