Class {
	#name : 'RwCAQRange',
	#superclass : 'RwCAQAst',
	#instVars : [
		'min',
		'max'
	],
	#category : 'RwCAQ-Core'
}

{ #category : 'instance creation' }
RwCAQRange class >> min: minVersion
max: maxVersion [

	^self new
		min: minVersion;
		max: maxVersion;
		yourself
]

{ #category : 'comparing' }
RwCAQRange >> = aRange [

	^(self class == aRange class
		and: [min = aRange min])
			and: [max = aRange max]
]

{ #category : 'comparing' }
RwCAQRange >> hash [

	^min hash
		bitXor: max hash
]

{ #category : 'accessing' }
RwCAQRange >> max [
	"Maximum version - exclusive"

	^max
]

{ #category : 'accessing' }
RwCAQRange >> max: aVersion [
	"Maximum version - exclusive"

	max := aVersion
]

{ #category : 'accessing' }
RwCAQRange >> min [
	"Minimum version - inclusive"

	^min
]

{ #category : 'accessing' }
RwCAQRange >> min: aVersion [
	"Minimum version - inclusive"

	min := aVersion
]
