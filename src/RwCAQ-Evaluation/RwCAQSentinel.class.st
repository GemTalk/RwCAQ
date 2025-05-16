Class {
	#name : 'RwCAQSentinel',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQSentinel class >> name: aSymbol [

	^self new
		name: aSymbol;
		yourself
]

{ #category : 'accessing' }
RwCAQSentinel >> name [
	"Returns the name of the unset variable."

	^name
]

{ #category : 'accessing' }
RwCAQSentinel >> name: aSymbol [
	"Set the name of the unknown variable."

	name := aSymbol
]
