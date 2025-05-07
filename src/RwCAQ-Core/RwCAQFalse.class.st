Class {
	#name : 'RwCAQFalse',
	#superclass : 'RwCAQAst',
	#category : 'RwCAQ-Core'
}

{ #category : 'comparing' }
RwCAQFalse >> = anObject [

	^self class == anObject class
]

{ #category : 'comparing' }
RwCAQFalse >> hash [

	^self class hash
]
