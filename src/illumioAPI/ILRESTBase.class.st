Class {
	#name : #ILRESTBase,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'illumioAPI-Core'
}

{ #category : #accessing }
ILRESTBase >> initialize [

	properties := Dictionary new

	
]

{ #category : #accessing }
ILRESTBase >> properties [

	^ properties
]

{ #category : #accessing }
ILRESTBase >> properties: anObject [

	properties := anObject
]

{ #category : #accessing }
ILRESTBase >> valueAt: aKey [

	^ properties at: aKey
]

{ #category : #accessing }
ILRESTBase >> valueAt: aKey put: aValue [
	^ properties at: aKey put: aValue
]
