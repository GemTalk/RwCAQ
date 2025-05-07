Class {
	#name : 'RwCAQTrue',
	#superclass : 'RwCAQAst',
	#category : 'RwCAQ-Core'
}

{ #category : 'comparing' }
RwCAQTrue >> = anObject [

	^self class == anObject class
]

{ #category : 'comparing' }
RwCAQTrue >> hash [

	^self class hash
]
