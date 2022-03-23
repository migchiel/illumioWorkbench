Class {
	#name : #ILRESTCoreServiceType,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Root'
}

{ #category : #initialization }
ILRESTCoreServiceType >> initialize [

	super initialize.
	self itemUrl: #core_service_types
]
