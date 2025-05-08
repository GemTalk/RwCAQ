Class {
	#name : 'RwCAQParser',
	#superclass : 'RwCAQGrammar',
	#category : 'RwCAQ-Core'
}

{ #category : 'accessing' }
RwCAQParser >> boolean [

	^super boolean ==> [:bool | RwCAQPrimitive value: bool]
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
		==> [:component | RwCAQPrimitive value: (RwGemStoneVersionNumber fromComponents: ({ component first} , component second)) ]
]
