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

	^super equality
		==> [:tokens | RwCAQEquality left: tokens first right: tokens last]
]

{ #category : 'accessing' }
RwCAQParser >> identifier [

	^super identifier
		==> [:id | RwCAQIdentifier name: id]
]

{ #category : 'accessing' }
RwCAQParser >> version [

	^super version
		==> [:aVersion | RwCAQPrimitive value: aVersion]
]
