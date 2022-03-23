Class {
	#name : #ILRESTWorkload,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #accessing }
ILRESTWorkload >> delete [
	^ self
		delete:
			self connection url / 'api' / self connection apiVersion / self href
]

{ #category : #building }
ILRESTWorkload >> enforcementMode [

	^ self valueAt: #enforcement_mode
]

{ #category : #accessing }
ILRESTWorkload >> hostname [

	^ self valueAt: #hostname
]

{ #category : #accessing }
ILRESTWorkload >> hostname: aName [

	^ self valueAt: #hostname put: aName
]

{ #category : #initialization }
ILRESTWorkload >> initialize [
	super initialize.
	self itemUrl: #workloads
]

{ #category : #accessing }
ILRESTWorkload >> interfaces [

	^ (self valueAt: #interfaces) at: 1
]

{ #category : #accessing }
ILRESTWorkload >> labels [

	^ Set new add: (self valueAt: #labels)
]

{ #category : #accessing }
ILRESTWorkload >> name [

	^ self valueAt: #name
]

{ #category : #accessing }
ILRESTWorkload >> name: aName [

	^ self valueAt: #name put: aName 
]

{ #category : #building }
ILRESTWorkload >> visibilityLevel [

	^ self valueAt: #visibility_level
]
