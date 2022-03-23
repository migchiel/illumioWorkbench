Class {
	#name : #ILRESTUser,
	#superclass : #ILRESTRoot,
	#category : #'illumioAPI-Root'
}

{ #category : #accessing }
ILRESTUser >> getApiKeys [

	| apiKey |
	apiKey := ILRESTApiKey new.
	apiKey connection: self connection.
	apiKey itemUrl: 'users/' , self id asString , '/api_keys'.
	^ apiKey getItems
]

{ #category : #'as yet unclassified' }
ILRESTUser >> id [

	^ self valueAt: #id
]

{ #category : #initialization }
ILRESTUser >> initialize [

	super initialize.
	self itemUrl: #users
]

{ #category : #'as yet unclassified' }
ILRESTUser >> lastLoginIP [

	^ self valueAt: #last_login_ip_address
]

{ #category : #'as yet unclassified' }
ILRESTUser >> loginCount [

	^ self valueAt: #login_count
]

{ #category : #'as yet unclassified' }
ILRESTUser >> username [

	^ self valueAt: #username
]

{ #category : #'as yet unclassified' }
ILRESTUser >> username: aName [

	^ self valueAt: #username put: aName
]
