"
I represent a service in illumio PCE Core
"
Class {
	#name : #Service,
	#superclass : #Object,
	#instVars : [
		'name',
		'port',
		'protocol'
	],
	#category : #'illumioWorkbench-Model'
}

{ #category : #accessing }
Service >> name [
	^ name
]

{ #category : #accessing }
Service >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Service >> port [
	^ port
]

{ #category : #accessing }
Service >> port: anObject [
	port := anObject
]

{ #category : #accessing }
Service >> protocol [
	^ protocol
]

{ #category : #accessing }
Service >> protocol: anObject [
	protocol := anObject
]
