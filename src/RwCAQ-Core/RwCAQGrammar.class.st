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
RwCAQGrammar >> trueLiteral [

	^('true' asParser , #'word' asParser not) ==> [:token | true]
]
