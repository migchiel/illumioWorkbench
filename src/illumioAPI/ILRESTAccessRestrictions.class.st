Class {
	#name : #ILRESTAccessRestrictions,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTAccessRestrictions >> initialize [

	super initialize.
	self itemUrl: #access_restrictions
]
