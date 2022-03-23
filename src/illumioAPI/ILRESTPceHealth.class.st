Class {
	#name : #ILRESTPceHealth,
	#superclass : #ILRESTRoot,
	#category : #'illumioAPI-Root'
}

{ #category : #'as yet unclassified' }
ILRESTPceHealth >> fqdn [

	^ self valueAt: #fqdn
]

{ #category : #initialization }
ILRESTPceHealth >> initialize [

	super initialize.
	self itemUrl: #health
]

{ #category : #'as yet unclassified' }
ILRESTPceHealth >> nodes [

	^ (self valueAt: #nodes) collect: [ :each | ILRESTPCENode new properties: each ]
		  asSet
]

{ #category : #'as yet unclassified' }
ILRESTPceHealth >> status [

	^ self valueAt: #status
]

{ #category : #'as yet unclassified' }
ILRESTPceHealth >> type [

	^ self valueAt: #type
]

{ #category : #'as yet unclassified' }
ILRESTPceHealth >> uptime [

	| upt |
	upt := self valueAt: #available_seconds.
	^ (Duration seconds: upt) humanReadablePrintString
]
