"
I represent a flow (a connection between a consumer and a provider using a particular protocol and port) in illumio PCE core
"
Class {
	#name : #Flow,
	#superclass : #Object,
	#instVars : [
		'src',
		'dst',
		'port',
		'proto'
	],
	#category : #'illumioWorkbench-Model'
}

{ #category : #accessing }
Flow >> dst [
	^ dst
]

{ #category : #accessing }
Flow >> dst: anObject [
	dst := anObject
]

{ #category : #accessing }
Flow >> port [
	^ port
]

{ #category : #accessing }
Flow >> port: anObject [
	port := anObject
]

{ #category : #accessing }
Flow >> proto [
	^ proto
]

{ #category : #accessing }
Flow >> proto: anObject [
	proto := anObject
]

{ #category : #accessing }
Flow >> src [
	^ src
]

{ #category : #accessing }
Flow >> src: anObject [
	src := anObject
]
