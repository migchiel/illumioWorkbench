"
I represent an IPList in illumio PCE core
"
Class {
	#name : #IPList,
	#superclass : #Object,
	#instVars : [
		'name',
		'description',
		'include',
		'exclude',
		'fqdns',
		'external_data_set',
		'external_data_ref',
		'href'
	],
	#category : #'illumioWorkbench-Model'
}

{ #category : #accessing }
IPList >> description [
	^ description
]

{ #category : #accessing }
IPList >> description: anObject [
	description := anObject
]

{ #category : #accessing }
IPList >> exclude [
	^ exclude
]

{ #category : #accessing }
IPList >> exclude: anObject [
	exclude := anObject
]

{ #category : #accessing }
IPList >> external_data_ref [
	^ external_data_ref
]

{ #category : #accessing }
IPList >> external_data_ref: anObject [
	external_data_ref := anObject
]

{ #category : #accessing }
IPList >> external_data_set [
	^ external_data_set
]

{ #category : #accessing }
IPList >> external_data_set: anObject [
	external_data_set := anObject
]

{ #category : #accessing }
IPList >> fqdns [
	^ fqdns
]

{ #category : #accessing }
IPList >> fqdns: anObject [
	fqdns := anObject
]

{ #category : #accessing }
IPList >> href [
	^ href
]

{ #category : #accessing }
IPList >> href: anObject [
	href := anObject
]

{ #category : #accessing }
IPList >> include [
	^ include
]

{ #category : #accessing }
IPList >> include: anObject [
	include := anObject
]

{ #category : #accessing }
IPList >> name [
	^ name
]

{ #category : #accessing }
IPList >> name: anObject [
	name := anObject
]
