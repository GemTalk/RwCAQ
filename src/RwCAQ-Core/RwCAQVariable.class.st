Class {
	#name : 'RwCAQVariable',
	#superclass : 'RwCAQAst',
	#instVars : [
		'name'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQVariable class >> name: aString [

	^self new
		name: aString;
		yourself
]

{ #category : 'comparing' }
RwCAQVariable >> = aVariable [

	^self class == aVariable class and: [self name = aVariable name]
]

{ #category : 'comparing' }
RwCAQVariable >> hash [

	^self name hash
]

{ #category : 'accessing' }
RwCAQVariable >> name [
	"Variable name to be resolved."

	^name
]

{ #category : 'accessing' }
RwCAQVariable >> name: aString [
	"Variable name to be resolved."

	name := aString
]

{ #category : 'printing' }
RwCAQVariable >> prettyPrintOn: aStream [

	aStream nextPutAll: name
]
