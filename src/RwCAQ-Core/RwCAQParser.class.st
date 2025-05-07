Class {
	#name : 'RwCAQParser',
	#superclass : 'PPCompositeParser',
	#instVars : [
		'expression',
		'boolean',
		'equality',
		'identifier',
		'version',
		'equalityOperand'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'accessing' }
RwCAQParser >> boolean [

	^('true' asParser ==> [:token | RwCAQTrue new])
	| ('false' asParser ==> [:token | RwCAQFalse new])
]

{ #category : 'accessing' }
RwCAQParser >> equality [

	^(equalityOperand, $= asParser trim, equalityOperand)
		==> [:tokens | RwCAQEquality left: tokens first right: tokens last]
]

{ #category : 'accessing' }
RwCAQParser >> equalityOperand [

	^identifier / version / boolean
]

{ #category : 'accessing' }
RwCAQParser >> expression [

	^(equality
	/ boolean
	/ identifier
	/ version) memoized
]

{ #category : 'accessing' }
RwCAQParser >> identifier [

	^(#letter asParser , (#word asParser | $. asParser) star) flatten trim
		==> [:token | RwCAQIdentifier name: token]
]

{ #category : 'accessing' }
RwCAQParser >> start [

	^expression end
]

{ #category : 'accessing' }
RwCAQParser >> version [

	| digitParser |
	digitParser := #digit asParser star ==> [:each | each isEmpty ifFalse: [(String withAll: each) asInteger]].
	^(digitParser , (('.' asParser , digitParser)  ==> [:component | component second]) star)
		==> [:component | RwGemStoneVersionNumber fromComponents: ({ component first} , component second) ]
]
