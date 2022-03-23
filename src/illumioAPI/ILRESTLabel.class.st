Class {
	#name : #ILRESTLabel,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTLabel >> initialize [

	super initialize.
	self itemUrl: #labels
]

{ #category : #accessing }
ILRESTLabel >> key [

	^ self valueAt: #key
]

{ #category : #accessing }
ILRESTLabel >> key: aKey [

	^ self valueAt: #key put: aKey
]

{ #category : #accessing }
ILRESTLabel >> makeApplication [

	self key: 'app'
]

{ #category : #accessing }
ILRESTLabel >> makeEnvironment [

	self key: 'env'
]

{ #category : #accessing }
ILRESTLabel >> makeLocation [

	self key: 'loc'
]

{ #category : #accessing }
ILRESTLabel >> makeRole [

	self key: 'role'
]

{ #category : #accessing }
ILRESTLabel >> value [

	^ self valueAt: #value
]

{ #category : #accessing }
ILRESTLabel >> value: aValue [

	^ self valueAt: #value put: aValue
]
