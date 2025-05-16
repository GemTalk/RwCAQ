Class {
	#name : 'RwCAQGrammar',
	#superclass : 'PPCompositeParser',
	#instVars : [
		'expression',
		'boolean',
		'falseLiteral',
		'trueLiteral',
		'equality',
		'version',
		'equalityOperand',
		'equalityOperator',
		'primitive',
		'unsignedInteger',
		'variable',
		'compare',
		'compareOperand',
		'compareOperator'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'compound' }
RwCAQGrammar >> boolean [

	^falseLiteral / trueLiteral
]

{ #category : 'compound' }
RwCAQGrammar >> compare [
	"This method is overridden in subclasses.
	Consider what changes need to be made
	in subclasses if you change this method."

	^compareOperand, compareOperator, compareOperand
]

{ #category : 'compound' }
RwCAQGrammar >> compareOperand [

	^version / variable
]

{ #category : 'compound' }
RwCAQGrammar >> compareOperator [

	^(($> asParser, $= asParser not)
	/ '>=' asParser
	/ ($< asParser, $= asParser not)
	/ '<=' asParser) flatten trim ==> [:token | token asSymbol]
]

{ #category : 'compound' }
RwCAQGrammar >> equality [
	"If changed, update subclasses.
	I'm not sure how to wrap the do: block
	to return the correct AST node in the parser
	other than to reimplement."

	| ep |
	ep := PPExpressionParser new.
	ep term: equalityOperand.
	ep group: [:g | g left: equalityOperator do: [:l :op :r | { l. op. r. }]].
	^ep
]

{ #category : 'compound' }
RwCAQGrammar >> equalityOperand [

	^compare / primitive / variable
]

{ #category : 'compound' }
RwCAQGrammar >> equalityOperator [

	^$= asParser flatten trim
]

{ #category : 'compound' }
RwCAQGrammar >> expression [

	^(equality
	/ compare
	/ boolean
	/ variable) memoized
]

{ #category : 'simple' }
RwCAQGrammar >> falseLiteral [

	^(('false' asParser , #'word' asParser not) ==> [:token | false]) trim
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
