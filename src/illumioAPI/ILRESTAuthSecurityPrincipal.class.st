Class {
	#name : #ILRESTAuthSecurityPrincipal,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTAuthSecurityPrincipal >> initialize [

	super initialize.
	self itemUrl: #auth_security_principals
]
