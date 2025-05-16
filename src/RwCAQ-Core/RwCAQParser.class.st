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
RwCAQParser >> compare [

	^super compare
		==> [:tokens | RwCAQBinaryCompare left: tokens first op: tokens second right: tokens last]
]

{ #category : 'accessing' }
RwCAQParser >> equality [
	"If changed, update superclass.
	I need an AST node to be returned
	by the parser and haven't figured out
	how to wrap it."

	| ep |
	ep := PPExpressionParser new.
	ep term: equalityOperand.
	ep group: [:g | g left: equalityOperator do: [:l :op :r | RwCAQEquality left: l right: r]].
	^ep
]

{ #category : 'accessing' }
RwCAQParser >> variable [

	^super variable
		==> [:id | RwCAQVariable name: id]
]

{ #category : 'accessing' }
RwCAQParser >> version [

	^super version
		==> [:aVersion | RwCAQPrimitive value: aVersion]
]
