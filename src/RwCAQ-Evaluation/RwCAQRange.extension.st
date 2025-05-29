Extension { #name : 'RwCAQRange' }

{ #category : 'evaluating' }
RwCAQRange >> evaluateIn: aContext [
	"We should always refer to context rather than synthesizing values outside of it.
	In Gemstone, 'gemstone.version' represents the version number being considered for this evaluation.
	It may differ from the version of GemStone executing the method.
	This will happen in tests. It could also happen when analyzing a project for a different GemStone version."

	| version |
	version := aContext
		resolve: 'gemstone.version'
		ifUnset: [^false].
	^version >= min and: [version < max]
]
