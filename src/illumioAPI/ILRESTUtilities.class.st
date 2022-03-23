Class {
	#name : #ILRESTUtilities,
	#superclass : #Object,
	#category : #'illumioAPI-Core'
}

{ #category : #'as yet unclassified' }
ILRESTUtilities class >> lookupLabels: aHREFcollection in: aLabelCollection [

	aHREFcollection do: [ :lbl | lbl at: 'href' ]
]
