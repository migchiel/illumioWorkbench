Class {
	#name : #ILRESTRoot,
	#superclass : #ILRESTItem,
	#traits : 'ILRESTRequest',
	#classTraits : 'ILRESTRequest classTrait',
	#category : #'illumioAPI-Root'
}

{ #category : #accessing }
ILRESTRoot >> baseUrl [

	^ '{1}/api/{2}/' format: { 
			  self pce url.
			  self pce apiVersion }
]
