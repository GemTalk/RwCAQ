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
		==> [:minMax | RwCAQClosedRange min: minMax first max: minMax last]
]

{ #category : 'accessing' }
RwCAQParser >> compareBlock [

	^[:l :op :r | RwCAQCompare
		left: l
		op: op
		right: r]
]

{ #category : 'accessing' }
RwCAQParser >> equalsBlock [

	^[:l :op :r | RwCAQEquality left: l op: op right: r]
]

{ #category : 'accessing' }
RwCAQParser >> logicBlock [

	^[:l :op :r | RwCAQLogic
		left: l
		op: op
		right: r]
]

{ #category : 'accessing' }
RwCAQParser >> openRange [

	^super openRange
		==> [:minMax | RwCAQOpenRange min: minMax first max: minMax last]
]

{ #category : 'accessing' }
RwCAQParser >> subversionRange [

	^super subversionRange
		==> [:minMax | RwCAQSubversionRange min: minMax first max: minMax last]
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
