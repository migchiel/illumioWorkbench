Class {
	#name : #ILRESTAuthenticationSettings,
	#superclass : #ILRESTRoot,
	#category : #'illumioAPI-Root'
}

{ #category : #'as yet unclassified' }
ILRESTAuthenticationSettings >> authenticationSettings [

	^ self valueAt: #authentication_type
]

{ #category : #initialization }
ILRESTAuthenticationSettings >> initialize [

	super initialize.
	self itemUrl: #authentication_settings
]
