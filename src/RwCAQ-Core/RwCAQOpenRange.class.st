Class {
	#name : 'RwCAQOpenRange',
	#superclass : 'RwCAQRange',
	#category : 'RwCAQ-Core'
}

{ #category : 'printing' }
RwCAQOpenRange >> prettyPrintOn: aStream [

	| size prefixVersion rangeBase |
	size := min size.
	prefixVersion := min
		copyFrom: 1
		to: size - 1.
	rangeBase := min at: size.
	aStream
		nextPutAll: 'gs';
		print: prefixVersion;
		nextPutAll: '.[';
		print: rangeBase;
		nextPutAll: '-]'
]
