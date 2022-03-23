Class {
	#name : #ILRESTSecurityPrincipal,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTSecurityPrincipal >> initialize [

	super initialize.
	self itemUrl: #security_principals
]
