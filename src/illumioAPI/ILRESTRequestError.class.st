Class {
	#name : #ILRESTRequestError,
	#superclass : #ILRESTError,
	#instVars : [
		'code',
		'json'
	],
	#category : #'illumioAPI-Error'
}

{ #category : #signalling }
ILRESTRequestError class >> signalCode: aNumber json: jsonDictionary [
	^ self new
		code: aNumber;
		json: jsonDictionary;
		signal
]

{ #category : #signalling }
ILRESTRequestError class >> signalResponse: aResponse [
	^ self 
		signalCode: aResponse code 
		json: (STON fromString: aResponse contents)
]

{ #category : #accessing }
ILRESTRequestError >> code [

	^ code
]

{ #category : #accessing }
ILRESTRequestError >> code: anObject [

	code := anObject
]

{ #category : #accessing }
ILRESTRequestError >> errorCode [
	^ self json at: 'error'
]

{ #category : #accessing }
ILRESTRequestError >> errorDescription [
	^ self json 
		at: 'error_description'
		ifAbsent: [ '<no description>' ]
]

{ #category : #accessing }
ILRESTRequestError >> json [

	^ json
]

{ #category : #accessing }
ILRESTRequestError >> json: anObject [

	json := anObject
]

{ #category : #accessing }
ILRESTRequestError >> messageText [
	^ '{1}:{2}:{3}' format: { 
	self code.	
	self errorCode. 
	self errorDescription }
]
