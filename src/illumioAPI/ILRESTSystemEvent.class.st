Class {
	#name : #ILRESTSystemEvent,
	#superclass : #ILRESTRoot,
	#category : #'illumioAPI-Root'
}

{ #category : #initialization }
ILRESTSystemEvent >> initialize [

	super initialize.
	self itemUrl: #system_events
]

{ #category : #accessing }
ILRESTSystemEvent >> status [

^ (self valueAt: #status) asString
	
]
