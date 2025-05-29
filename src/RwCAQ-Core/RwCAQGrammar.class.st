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
		'compareOperator',
		'logicOperator',
		'range',
		'openRange',
		'closedRange',
		'subversionRange'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'compound' }
RwCAQGrammar >> boolean [

	^falseLiteral / trueLiteral
]

{ #category : 'simple' }
RwCAQGrammar >> closedRange [
	"'gs3.[5-9]' is equivalent to '3.5 <= gemstone.version < 3.10'"

	| prefix dottedComp rangeSpecifier versionBase |
	prefix := 'gs' asParser trimLeft.
	dottedComp := ($. asParser, unsignedInteger) ==> [:comp | comp second].
	versionBase := (prefix, unsignedInteger, dottedComp star, $. asParser) ==> [:t | { t second. }, t third ].
	rangeSpecifier := ($[ asParser, unsignedInteger, $- asParser, unsignedInteger, $] asParser) ==> [:tokens | { tokens second. tokens at: 4. }].
	^(versionBase, rangeSpecifier) trim
		==> [:def | | minComps maxComps inclusiveMin exclusiveMax |
			minComps := def first copy, { def last first }.
			inclusiveMin := RwGemStoneVersionNumber fromComponents: minComps.
			maxComps := def first copy, { def last last + 1 }.
			exclusiveMax := RwGemStoneVersionNumber fromComponents: maxComps.
			{inclusiveMin. exclusiveMax.}]
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
		group: [:g | g left: logicOperator do: self logicBlock].
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

{ #category : 'compound' }
RwCAQGrammar >> logicOperator [

	^($| asParser
	/ $& asParser) flatten trim ==> [:token | token asSymbol]
]

{ #category : 'simple' }
RwCAQGrammar >> openRange [
	"'gs3.[5-]' is equivalent to '3.5 <= gemstone.version < 4'"

	| prefix dottedComp rangeSpecifier versionBase |
	prefix := 'gs' asParser trimLeft.
	dottedComp := ($. asParser, unsignedInteger) ==> [:comp | comp second].
	versionBase := (prefix, unsignedInteger, dottedComp star, $. asParser) ==> [:t | { t second. }, t third ].
	rangeSpecifier := ($[ asParser, unsignedInteger, $- asParser, $] asParser) ==> [:tokens | tokens second].
	^(versionBase, rangeSpecifier) trim
		==> [:def | | minComps maxComps inclusiveMin exclusiveMax |
			minComps := def first copy, { def last }.
			inclusiveMin := RwGemStoneVersionNumber fromComponents: minComps.
			maxComps := def first copy.
			maxComps at: maxComps size put: (maxComps last + 1).
			exclusiveMax := RwGemStoneVersionNumber fromComponents: maxComps.
			{inclusiveMin. exclusiveMax.}]
]

{ #category : 'accessing' }
RwCAQGrammar >> primitive [

	^version / range / boolean / variable
]

{ #category : 'simple' }
RwCAQGrammar >> range [

	^openRange / closedRange / subversionRange
]

{ #category : 'compound' }
RwCAQGrammar >> start [

	^expression end
]

{ #category : 'simple' }
RwCAQGrammar >> subversionRange [
	"'gs3.5.x' is equivalent to '3.5 <= gemstone.version < 3.6'"

	| prefix subversion rangeSpecifier versionBase |
	prefix := 'gs' asParser trimLeft.
	subversion := ($. asParser, unsignedInteger) ==> [:comp | comp second].
	rangeSpecifier := '.x' asParser.
	versionBase := (prefix, unsignedInteger, subversion star, rangeSpecifier) ==> [:t | { t second. }, t third ].
	^versionBase trim
		==> [:minComps | |  maxComps inclusiveMin exclusiveMax |
			maxComps := minComps copy.
			maxComps at: maxComps size put: (maxComps last + 1).
			inclusiveMin := RwGemStoneVersionNumber fromComponents: minComps.
			exclusiveMax := RwGemStoneVersionNumber fromComponents: maxComps.
			{inclusiveMin. exclusiveMax.}]
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

	^(#letter asParser , (#word asParser / $. asParser) star) flatten trim
]

{ #category : 'simple' }
RwCAQGrammar >> version [

	| start dottedComp |
	start := unsignedInteger.
	dottedComp := ($. asParser, unsignedInteger) ==> [:comp | comp second].
	^(start, dottedComp star) trim ==> [:comps | RwGemStoneVersionNumber fromComponents: ({ comps first} , comps second)]
]
