Class {
	#name : #ILRESTService,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTService >> initialize [

	super initialize.
	self itemUrl: 'sec_policy/draft/services'
]
