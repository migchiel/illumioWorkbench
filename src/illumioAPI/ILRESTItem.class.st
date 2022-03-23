Class {
	#name : #ILRESTItem,
	#superclass : #ILRESTBase,
	#traits : 'ILRESTRequest',
	#classTraits : 'ILRESTRequest classTrait',
	#instVars : [
		'itemUrl',
		'pce'
	],
	#category : #'illumioAPI-Core'
}

{ #category : #operations }
ILRESTItem >> baseUrl [

	self subclassResponsibility
]

{ #category : #operations }
ILRESTItem >> create [

	^ self post: self baseUrl , '/' , self itemUrl with: [ :request | 
		  request entity: (ZnEntity
				   with: (STONJSON toString: self properties)
				   type: ZnMimeType applicationJson) ]
]

{ #category : #accessing }
ILRESTItem >> createdAt [

	^ self valueAt: #created_at
]

{ #category : #accessing }
ILRESTItem >> deletedAt [

	^ self valueAt: #deleted_at
]

{ #category : #accessing }
ILRESTItem >> getAll [

	^ self get: self baseUrl , self itemUrl with: [ :request | request ]
]

{ #category : #accessing }
ILRESTItem >> href [

	^ self valueAt: #href
]

{ #category : #accessing }
ILRESTItem >> itemUrl [

	^ itemUrl
]

{ #category : #accessing }
ILRESTItem >> itemUrl: anObject [

	itemUrl := anObject
]

{ #category : #accessing }
ILRESTItem >> pce [

	^ pce
]

{ #category : #accessing }
ILRESTItem >> pce: anPCE [

	pce := anPCE
]

{ #category : #accessing }
ILRESTItem >> updatedAt [

	^ self valueAt: #updated_at
]
