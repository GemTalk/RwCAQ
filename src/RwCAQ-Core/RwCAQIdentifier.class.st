Class {
	#name : 'RwCAQIdentifier',
	#superclass : 'RwCAQAst',
	#instVars : [
		'name'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQIdentifier class >> name: aString [

	^self new
		name: aString;
		yourself
]

{ #category : 'comparing' }
RwCAQIdentifier >> = aVariable [

	^self class == aVariable class and: [self name = aVariable name]
]

{ #category : 'comparing' }
RwCAQIdentifier >> hash [

	^self name hash
]

{ #category : 'accessing' }
RwCAQIdentifier >> name [
	"Variable name to be resolved."

	^name
]

{ #category : 'accessing' }
RwCAQIdentifier >> name: aString [
	"Variable name to be resolved."

	name := aString
]
