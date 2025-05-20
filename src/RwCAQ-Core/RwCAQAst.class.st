Class {
	#name : 'RwCAQAst',
	#superclass : 'Object',
	#category : 'RwCAQ-Core'
}

{ #category : 'printing' }
RwCAQAst >> prettyPrintOn: aStream [

	self subclassResponsibility
]

{ #category : 'printing' }
RwCAQAst >> printOn: aStream [

	self prettyPrintOn: aStream
]
