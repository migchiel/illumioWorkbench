Class {
	#name : #ILRESTLoadBalancers,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTLoadBalancers >> initialize [

	super initialize.
	self itemUrl: #slbs
]
