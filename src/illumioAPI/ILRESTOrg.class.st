Class {
	#name : #ILRESTOrg,
	#superclass : #ILRESTItem,
	#traits : 'ILRESTRequest',
	#classTraits : 'ILRESTRequest classTrait',
	#category : #'illumioAPI-Org'
}

{ #category : #accessing }
ILRESTOrg >> baseUrl [ 

	^ '{1}/api/{2}/orgs/{3}/' format: {self pce url . self pce apiVersion . self pce org}
]
