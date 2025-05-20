Class {
	#name : 'RwCAQComparableExpected',
	#superclass : 'RwCAQInvalidOperand',
	#category : 'RwCAQ-Core'
}

{ #category : 'accessing' }
RwCAQComparableExpected >> generatedMessageText [
	"Generate a reasonable message text for this exception."

	^String
		streamContents:
			[:stream |
			stream nextPutAll: 'Expected comparable operand after evaluating `'.
			subexpression prettyPrintOn: stream.
			stream nextPutAll: '` in `'.
			expression prettyPrintOn: stream.
			stream nextPutAll: '`. Operand was `'.
			operand printOn: stream.
			stream nextPutAll: '`.']
]

{ #category : 'accessing' }
RwCAQComparableExpected >> messageText [

	^messageText ifNil: [self generatedMessageText]
]
