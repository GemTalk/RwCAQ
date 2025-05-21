Class {
	#name : 'RwCAQParser',
	#superclass : 'RwCAQGrammar',
	#category : 'RwCAQ-Core'
}

{ #category : 'accessing' }
RwCAQParser >> boolean [

	^super boolean ==> [:bool | RwCAQValue value: bool]
]

{ #category : 'accessing' }
RwCAQParser >> closedRange [

	^super closedRange
		==> [:minMax | RwCAQRange min: minMax first max: minMax last]
]

{ #category : 'accessing' }
RwCAQParser >> compareBlock [

	^[:l :op :r | RwCAQBinaryCompare
		left: l
		op: op asSymbol
		right: r]
]

{ #category : 'accessing' }
RwCAQParser >> equalsBlock [

	^[:l :op :r | RwCAQEquality left: l right: r]
]

{ #category : 'accessing' }
RwCAQParser >> logicBlock [

	^[:l :op :r | RwCAQBooleanLogic
		left: l
		op: op asSymbol
		right: r]
]

{ #category : 'accessing' }
RwCAQParser >> openRange [

	^super openRange
		==> [:minMax | RwCAQRange min: minMax first max: minMax last]
]

{ #category : 'accessing' }
RwCAQParser >> subversionRange [

	^super subversionRange
		==> [:minMax | RwCAQRange min: minMax first max: minMax last]
]

{ #category : 'accessing' }
RwCAQParser >> variable [

	^super variable
		==> [:id | RwCAQVariable name: id]
]

{ #category : 'accessing' }
RwCAQParser >> version [

	^super version
		==> [:aVersion | RwCAQValue value: aVersion]
]
