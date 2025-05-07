Extension { #name : 'RwGemStoneVersionNumber' }

{ #category : 'extensions' }
RwGemStoneVersionNumber class >> fromComponents: aSequenceableCollection [
	"Create an instance where each component in the version number is from anArray."

	| instance |
	instance := self new: aSequenceableCollection size.
	aSequenceableCollection withIndexDo: [:each :i | instance at: i put: each].
	^instance
]
