Class {
	#name : #ILRESTTrafficCollector,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTTrafficCollector >> initialize [

	super initialize.
	self itemUrl: 'settings/traffic_collector'
]
