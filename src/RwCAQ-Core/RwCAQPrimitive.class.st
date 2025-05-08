Class {
	#name : 'RwCAQPrimitive',
	#superclass : 'RwCAQAst',
	#instVars : [
		'value'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQPrimitive class >> value: anObject [

	^self new
		value: anObject;
		yourself
]

{ #category : 'comparing' }
RwCAQPrimitive >> = aValue [

	^self class == aValue class and: [self value = aValue value]
]

{ #category : 'comparing' }
RwCAQPrimitive >> hash [

	^value hash
]

{ #category : 'accessing' }
RwCAQPrimitive >> value [
	"Return the held value"

	^value
]

{ #category : 'accessing' }
RwCAQPrimitive >> value: anObject [
	"Set the held value"

	value := anObject
]
