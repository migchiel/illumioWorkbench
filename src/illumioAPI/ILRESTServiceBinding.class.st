Class {
	#name : #ILRESTServiceBinding,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTServiceBinding >> initialize [

	super initialize.
	self itemUrl: #service_bindings
]
