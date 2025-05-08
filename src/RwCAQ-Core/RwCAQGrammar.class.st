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
		'equalityOperand'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'accessing' }
RwCAQGrammar >> boolean [

	^falseLiteral / trueLiteral
]

{ #category : 'accessing' }
RwCAQGrammar >> equality [

	^equalityOperand, $= asParser trim, equalityOperand
]

{ #category : 'accessing' }
RwCAQGrammar >> equalityOperand [

	^identifier / version / boolean
]

{ #category : 'accessing' }
RwCAQGrammar >> expression [

	^(equality
	/ boolean
	/ identifier
	/ version) memoized
]

{ #category : 'accessing' }
RwCAQGrammar >> falseLiteral [

	^('false' asParser , #'word' asParser not) ==> [:token | false]
]

{ #category : 'accessing' }
RwCAQGrammar >> identifier [

	^(#letter asParser , (#word asParser | $. asParser) star) flatten trim
]

{ #category : 'accessing' }
RwCAQGrammar >> start [

	^expression end
]

{ #category : 'accessing' }
RwCAQGrammar >> trueLiteral [

	^('true' asParser , #'word' asParser not) ==> [:token | true]
]

{ #category : 'accessing' }
RwCAQGrammar >> version [

	| digitParser |
	digitParser := #digit asParser star ==> [:each | each isEmpty ifFalse: [(String withAll: each) asInteger]].
	^(digitParser , (('.' asParser , digitParser)  ==> [:component | component second]) star)
		==> [:component | RwGemStoneVersionNumber fromComponents: ({ component first} , component second)]
]
