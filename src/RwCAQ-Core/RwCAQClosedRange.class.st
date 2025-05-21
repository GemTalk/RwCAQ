Class {
	#name : 'RwCAQClosedRange',
	#superclass : 'RwCAQRange',
	#category : 'RwCAQ-Core'
}

{ #category : 'printing' }
RwCAQClosedRange >> prettyPrintOn: aStream [

	| size prefixVersion rangeBase rangeMax |
	size := min size.
	prefixVersion := min
		copyFrom: 1
		to: size - 1.
	rangeBase := min at: size.
	rangeMax := (max at: size) - 1.
	aStream
		nextPutAll: 'gs';
		print: prefixVersion;
		nextPutAll: '.[';
		print: rangeBase;
		nextPut: $-;
		print: rangeMax;
		nextPut: $]
]
