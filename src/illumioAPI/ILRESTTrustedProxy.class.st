Class {
	#name : #ILRESTTrustedProxy,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTTrustedProxy >> initialize [

	super initialize.
	self itemUrl: 'settings/trusted_proxy_ips'
]
