Class {
	#name : #ILRESTDetectedCoreService,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Root'
}

{ #category : #initialization }
ILRESTDetectedCoreService >> initialize [

	super initialize.
	self itemUrl: #detected_core_services
]
