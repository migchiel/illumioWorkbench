Class {
	#name : #ILRESTIpList,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #operations }
ILRESTIpList >> create [
	^ self
		post:
			self connection url / 'api' / self connection apiVersion / 'orgs'
				/ self connection org / 'sec_policy/draft/ip_lists'
		with: [ :request | 
			request
				entity:
					(ZnEntity
						with: (STONJSON toString: self properties)
						type: ZnMimeType applicationJson) ]
]

{ #category : #'submorphs-add/remove' }
ILRESTIpList >> delete [
	^ self
		delete: self connection url / 'api' / self connection apiVersion / self href
]

{ #category : #initialization }
ILRESTIpList >> initialize [

	super initialize.
	self itemUrl: 'sec_policy/draft/ip_lists'
]

{ #category : #accessing }
ILRESTIpList >> name [
	^ self valueAt: #name
]

{ #category : #accessing }
ILRESTIpList >> name: aName [
	^ self valueAt: #name put: aName
]
