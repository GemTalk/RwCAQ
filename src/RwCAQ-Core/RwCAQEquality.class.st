Class {
	#name : 'RwCAQEquality',
	#superclass : 'RwCAQBinaryOperation',
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQEquality class >> left: leftNode
right: rightNode [

	^self
		left: leftNode
		op: #'='
		right: rightNode
]
