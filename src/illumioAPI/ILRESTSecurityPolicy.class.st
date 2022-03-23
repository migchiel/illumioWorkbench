Class {
	#name : #ILRESTSecurityPolicy,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTSecurityPolicy >> initialize [

	super initialize.
	self itemUrl: #sec_policy
]
