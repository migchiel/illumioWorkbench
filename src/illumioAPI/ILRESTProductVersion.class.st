Class {
	#name : #ILRESTProductVersion,
	#superclass : #ILRESTRoot,
	#category : #'illumioAPI-Root'
}

{ #category : #converting }
ILRESTProductVersion >> asString [

	^ self productName , '-' , self version , '-' , self build
]

{ #category : #building }
ILRESTProductVersion >> build [

	^ (self valueAt: #build) asString
]

{ #category : #initialization }
ILRESTProductVersion >> initialize [

	super initialize.
	self itemUrl: #product_version
]

{ #category : #building }
ILRESTProductVersion >> productName [

	^ self valueAt: #product_name
]

{ #category : #building }
ILRESTProductVersion >> version [

	^ self valueAt: #version
]
