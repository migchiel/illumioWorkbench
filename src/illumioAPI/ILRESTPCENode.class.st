Class {
	#name : #ILRESTPCENode,
	#superclass : #ILRESTBase,
	#category : #'illumioAPI-Helper'
}

{ #category : #accessing }
ILRESTPCENode >> hostname [

	^ self valueAt: #hostname
]

{ #category : #accessing }
ILRESTPCENode >> ipAddress [

	^ self valueAt: #ip_address
]

{ #category : #accessing }
ILRESTPCENode >> memory [

	| mem |
	mem := self valueAt: #memory.
	^ 'Memory status: ' , (mem at: #status) , ' Usage: '
	  , (mem at: #percent) asString , '%'
]

{ #category : #accessing }
ILRESTPCENode >> runlevel [

	^ self valueAt: #runlevel
]

{ #category : #accessing }
ILRESTPCENode >> type [

	^ self valueAt: #type
]

{ #category : #accessing }
ILRESTPCENode >> uptime [

	| upt |
	upt := self valueAt: #uptime_seconds.
	^ (Duration seconds: upt) humanReadablePrintString
]
