Class {
	#name : 'RwCAQContext',
	#superclass : 'Object',
	#instVars : [
		'variables'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQContext class >> new [

	^super new initialize
]

{ #category : 'accessing' }
RwCAQContext >> at: aSymbol [

	^variables at: aSymbol ifAbsent: [false]
]

{ #category : 'initialization' }
RwCAQContext >> initialize [

	super initialize.
	variables := IdentityDictionary new
]

{ #category : 'setting' }
RwCAQContext >> set: aSymbol [

	^self
		set: aSymbol
		to: true
]

{ #category : 'setting' }
RwCAQContext >> set: aSymbol
to: aValue [

	^variables
		at: aSymbol
		put: aValue
]
