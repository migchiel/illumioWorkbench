Class {
	#name : #ILRESTApplicationGroup,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTApplicationGroup >> initialize [
	super initialize.
	self itemUrl: #app_groups
]
