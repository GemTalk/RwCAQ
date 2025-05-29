Extension { #name : 'RwCAQVariable' }

{ #category : 'evaluating' }
RwCAQVariable >> evaluateIn: aContext [

	^aContext
		resolve: name
		ifUnset: [RwCAQSentinel name: name]
]
