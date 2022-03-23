Class {
	#name : #ILRESTLicense,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTLicense >> initialize [
	super initialize.
	self itemUrl: #licenses
]
