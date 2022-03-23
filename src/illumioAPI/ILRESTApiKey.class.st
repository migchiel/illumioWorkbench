Class {
	#name : #ILRESTApiKey,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Root'
}

{ #category : #initialization }
ILRESTApiKey >> initialize [

	super initialize.
	self itemUrl: #api_keys
]
