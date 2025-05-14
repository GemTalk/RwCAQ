Class {
	#name : 'RwCAQGrammar',
	#superclass : 'PPCompositeParser',
	#instVars : [
		'expression',
		'boolean',
		'falseLiteral',
		'trueLiteral',
		'equality',
		'identifier',
		'version',
		'equalityOperand',
		'equalityOperator',
		'primitive',
		'unsignedInteger'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'compound' }
RwCAQGrammar >> boolean [

	^falseLiteral / trueLiteral
]

{ #category : 'compound' }
RwCAQGrammar >> equality [

	^equalityOperand, equalityOperator, equalityOperand
]

{ #category : 'compound' }
RwCAQGrammar >> equalityOperand [

	^primitive / identifier
]

{ #category : 'compound' }
RwCAQGrammar >> equalityOperator [

	^$= asParser trim
]

{ #category : 'compound' }
RwCAQGrammar >> expression [

	^(equality
	/ boolean
	/ identifier) memoized
]

{ #category : 'simple' }
RwCAQGrammar >> falseLiteral [

	^(('false' asParser , #'word' asParser not) ==> [:token | false]) trim
]

{ #category : 'simple' }
RwCAQGrammar >> identifier [

	^(#letter asParser , (#word asParser / $. asParser) star) flatten trim ==> [:name | name asSymbol]
]

{ #category : 'compound' }
RwCAQGrammar >> primitive [

	^version / boolean
]

{ #category : 'compound' }
RwCAQGrammar >> start [

	^expression end
]

{ #category : 'simple' }
RwCAQGrammar >> trueLiteral [

	^(('true' asParser , #'word' asParser not) trim ==> [:token | true]) trim
]

{ #category : 'simple' }
RwCAQGrammar >> unsignedInteger [

	^#digit asParser plus flatten ==> [:str | str asInteger]
]

{ #category : 'simple' }
RwCAQGrammar >> version [

	| start dottedComp |
	start := unsignedInteger.
	dottedComp := ($. asParser, unsignedInteger) ==> [:comp | comp second].
	^(start, dottedComp star) trim ==> [:comps | RwGemStoneVersionNumber fromComponents: ({ comps first} , comps second)]
]
