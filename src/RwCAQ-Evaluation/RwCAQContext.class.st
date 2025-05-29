"
RwCAQContext serves one main purpose--provide the mechanism for binding variables to values during RwCAQ expression evaluation. Explicit variables are set on a LoadSpecification. These resolve to boolean values. Implicit variables are set to represent the Smalltalk environment. For instance, 'gemstone' is set when evaluating for GemStone.

RwCAQContext is populated with all of the variables relevant to a particular evaluation. This permits Rowan to define the context for the evaluation differently from the context it is running in. For instance, the variable 'gemstone.version' represents the version of GemStone used in the calculation. If a GemStone 3.7.4 gem is analyzing a project for GemStone 3.7.5, this variable would resolve to 3.7.5. Setting the variable explicitly in context, rather than inferring it based on evaluation environment, provides flexibility in analsis.

The keys are strings rather than symbols. This is primarily to avoid allocating symbols in GemStone, which are more costly as they happen in the SymbolGem rather than the current Gem. The allocated strings are ephemeral. Using strings prevents these ephemeral objects from ever being committed.

Since strings and symbols, representing the same Codepoint sequence, are not equivalent in GemStone,  strings should be used exclusively.
"
Class {
	#name : 'RwCAQContext',
	#superclass : 'Object',
	#instVars : [
		'variables'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQContext class >> new [

	^super new initialize
]

{ #category : 'initialization' }
RwCAQContext >> initialize [

	super initialize.
	variables := Dictionary new
]

{ #category : 'accessing' }
RwCAQContext >> resolve: aString
ifUnset: aBlock [

	^variables
		at: aString
		ifAbsent: aBlock
]

{ #category : 'setting' }
RwCAQContext >> set: aString [

	^self
		set: aString
		to: true
]

{ #category : 'setting' }
RwCAQContext >> set: aString
to: aValue [

	^variables
		at: aString
		put: aValue
]
