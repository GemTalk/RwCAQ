Class {
	#name : 'RwCAQGrammar',
	#superclass : 'PPCompositeParser',
	#instVars : [
		'expression',
		'primitive',
		'boolean',
		'falseLiteral',
		'trueLiteral',
		'version',
		'unsignedInteger',
		'variable',
		'compareOperator'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'compound' }
RwCAQGrammar >> boolean [

	^falseLiteral / trueLiteral
]

{ #category : 'accessing' }
RwCAQGrammar >> compareBlock [

	^[:l :op :r | { l. op. r. }]
]

{ #category : 'compound' }
RwCAQGrammar >> compareOperator [

	^(($> asParser, $= asParser not)
	/ '>=' asParser
	/ ($< asParser, $= asParser not)
	/ '<=' asParser) flatten trim ==> [:token | token asSymbol]
]

{ #category : 'accessing' }
RwCAQGrammar >> equalsBlock [

	^[:l :op :r | {l. op. r.}]
]

{ #category : 'compound' }
RwCAQGrammar >> expression [

	| ops |
	ops := PPExpressionParser new.
	ops term: primitive.
	ops
		group: [:g | g left: compareOperator do: self compareBlock];
		group: [:g | g left: $= asParser flatten trim do: self equalsBlock];
		group: [:g | g left: $| asParser flatten trim do: self logicBlock].
	^ops memoized
]

{ #category : 'simple' }
RwCAQGrammar >> falseLiteral [

	^(('false' asParser , #'word' asParser not) ==> [:token | false]) trim
]

{ #category : 'accessing' }
RwCAQGrammar >> logicBlock [

	^[:l :op :r | {l. op. r.}]
]

{ #category : 'accessing' }
RwCAQGrammar >> primitive [

	^version / boolean / variable
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
RwCAQGrammar >> variable [

	^(#letter asParser , (#word asParser / $. asParser) star) flatten trim ==> [:name | name asSymbol]
]

{ #category : 'simple' }
RwCAQGrammar >> version [

	| start dottedComp |
	start := unsignedInteger.
	dottedComp := ($. asParser, unsignedInteger) ==> [:comp | comp second].
	^(start, dottedComp star) trim ==> [:comps | RwGemStoneVersionNumber fromComponents: ({ comps first} , comps second)]
]
