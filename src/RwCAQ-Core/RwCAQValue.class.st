Class {
	#name : 'RwCAQValue',
	#superclass : 'RwCAQAst',
	#instVars : [
		'value'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQValue class >> value: anObject [

	^self new
		value: anObject;
		yourself
]

{ #category : 'comparing' }
RwCAQValue >> = aValue [

	^self class == aValue class and: [self value = aValue value]
]

{ #category : 'comparing' }
RwCAQValue >> hash [

	^value hash
]

{ #category : 'printing' }
RwCAQValue >> prettyPrintOn: aStream [

	value printOn: aStream
]

{ #category : 'accessing' }
RwCAQValue >> value [
	"Return the held value"

	^value
]

{ #category : 'accessing' }
RwCAQValue >> value: anObject [
	"Set the held value"

	value := anObject
]
