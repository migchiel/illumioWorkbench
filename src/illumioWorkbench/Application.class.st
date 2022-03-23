"
I represent an Application in illumio PCE core
"
Class {
	#name : #Application,
	#superclass : #Object,
	#instVars : [
		'name',
		'location',
		'environment'
	],
	#category : #'illumioWorkbench-Model'
}

{ #category : #accessing }
Application >> environment [
	^ environment
]

{ #category : #accessing }
Application >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
Application >> location [
	^ location
]

{ #category : #accessing }
Application >> location: anObject [
	location := anObject
]

{ #category : #accessing }
Application >> name [
	^ name
]

{ #category : #accessing }
Application >> name: anObject [
	name := anObject
]
