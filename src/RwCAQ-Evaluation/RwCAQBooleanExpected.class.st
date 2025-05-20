Class {
	#name : 'RwCAQBooleanExpected',
	#superclass : 'RwCAQInvalidOperand',
	#category : 'RwCAQ-Core'
}

{ #category : 'accessing' }
RwCAQBooleanExpected >> generatedMessageText [
	"Generate a reasonable message text for this exception."

	^String
		streamContents:
			[:stream |
			stream nextPutAll: 'Expected boolean operand after evaluating `'.
			subexpression prettyPrintOn: stream.
			stream nextPutAll: '` in `'.
			expression prettyPrintOn: stream.
			stream nextPutAll: '`. Operand was `'.
			operand printOn: stream.
			stream nextPutAll: '`.']
]

{ #category : 'accessing' }
RwCAQBooleanExpected >> messageText [

	^messageText ifNil: [self generatedMessageText]
]
