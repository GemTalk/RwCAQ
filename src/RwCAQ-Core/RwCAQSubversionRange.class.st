Class {
	#name : 'RwCAQSubversionRange',
	#superclass : 'RwCAQRange',
	#category : 'RwCAQ-Core'
}

{ #category : 'printing' }
RwCAQSubversionRange >> prettyPrintOn: aStream [

	aStream
		nextPutAll: 'gs';
		print: min;
		nextPutAll: '.x'
]
