Trait {
	#name : #ILRESTRequest,
	#category : #'illumioAPI-Core'
}

{ #category : #API }
ILRESTRequest >> delete: anUrl [
	^ self rawDelete: anUrl with: [ :request |  ]
]

{ #category : #API }
ILRESTRequest >> delete: anUrl with: aBlock [

	^ STON fromString: (self rawDelete: anUrl with: aBlock)
]

{ #category : #API }
ILRESTRequest >> executeRequest: requestMethod url: anUrl with: aBlock [

	^ self withResponseHandling: [ 
		  ZnClient new
			  username: self pce apiKeyID password: self pce apiSecret;
			  url: anUrl;
			  in: aBlock;
			  beOneShot;
			  method: requestMethod;
			  execute;
			  response ]
]

{ #category : #API }
ILRESTRequest >> get: anUrl [

	^STON fromString: (self rawGet: anUrl with: [ :request |  ])
	
]

{ #category : #API }
ILRESTRequest >> get: anUrl with: aBlock [
	^ STON fromString: (self 
		rawGet: anUrl 
		with: aBlock)
]

{ #category : #'accessing - backend' }
ILRESTRequest >> getItems [

	| result |
	result := self getAll.
	^ (result collect: [ :each | 
		   self class new
			   properties: each;
			   pce: self pce ]) asSet
]

{ #category : #'accessing - backend' }
ILRESTRequest >> getItems: anItem [

	| result |
	result := anItem getAll.
	^ (result collect: [ :each | 
		   anItem class new
			   properties: each;
			   pce: anItem pce ]) asSet
]

{ #category : #API }
ILRESTRequest >> post: anUrl [
	^ STON fromString: (self 
		rawPost: anUrl 
		with: [ :request | ])
]

{ #category : #API }
ILRESTRequest >> post: anUrl with: aBlock [
	^ STON fromString: (self 
		rawPost: anUrl 
		with: aBlock)
]

{ #category : #API }
ILRESTRequest >> rawDelete: anUrl with: aBlock [

	^ self executeRequest: #DELETE url: anUrl with: aBlock
]

{ #category : #API }
ILRESTRequest >> rawGet: anUrl with: aBlock [
	^ self executeRequest: #GET url: anUrl with: aBlock 
]

{ #category : #API }
ILRESTRequest >> rawPost: anUrl with: aBlock [
	^ self executeRequest: #POST url: anUrl with: aBlock
]

{ #category : #API }
ILRESTRequest >> withResponseHandling: aBlock [
	| response |
	
	response := aBlock value.
	response isSuccess
		ifFalse: [ ILRESTRequestError signalResponse: response ].
	^ response contents
]
