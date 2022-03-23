"
I represent a Workload in illumio PCE core
"
Class {
	#name : #Workload,
	#superclass : #Object,
	#instVars : [
		'hostname',
		'name',
		'role',
		'application',
		'environment',
		'location',
		'operatingSystem',
		'operatingSystemDetail',
		'interfaceName',
		'ipAddresses'
	],
	#category : #'illumioWorkbench-Model'
}

{ #category : #'as yet unclassified' }
Workload >> addIPAddress: aString [
	ipAddresses add: aString
]

{ #category : #'as yet unclassified' }
Workload >> ael: app [
	self application: app name.
	self environment: app environment.
	self location: app location
]

{ #category : #accessing }
Workload >> application [
	^ application
]

{ #category : #accessing }
Workload >> application: anObject [
	application := anObject
]

{ #category : #accessing }
Workload >> environment [
	^ environment
]

{ #category : #accessing }
Workload >> environment: anObject [
	environment := anObject
]

{ #category : #accessing }
Workload >> hostname [
	^ hostname
]

{ #category : #accessing }
Workload >> hostname: anObject [
	hostname := anObject.
]

{ #category : #initialization }
Workload >> initialize [ 
	"Default interface name"
	interfaceName := 'eth'.
	ipAddresses := Set new.
]

{ #category : #accessing }
Workload >> interfaceName [
	^ interfaceName 
]

{ #category : #accessing }
Workload >> interfaceName: aString [
	interfaceName  := aString
]

{ #category : #'as yet unclassified' }
Workload >> interfacesAsString [
	| interfaces count ifaces ifcnt|
	
	count := ipAddresses size.
	count = 0 ifTrue: [ ^ '' ].
	ifaces := ipAddresses asArray.
	interfaces := interfaceName, '0:', (ifaces at: 1).
	count = 1 ifTrue: [ ^ interfaces].
	ifcnt := 1.
	ifaces from: 2 to: count do: [ :i | interfaces := interfaces, ';', interfaceName, ifcnt asString, ':', i . ifcnt := ifcnt + 1].
	^ interfaces
]

{ #category : #accessing }
Workload >> ipAddresses [
	^ ipAddresses
]

{ #category : #accessing }
Workload >> location [
	^ location
]

{ #category : #accessing }
Workload >> location: anObject [
	location := anObject
]

{ #category : #accessing }
Workload >> name [
	^ name
]

{ #category : #accessing }
Workload >> name: anObject [
	name := anObject.
	hostname := name
]

{ #category : #accessing }
Workload >> operatingSystem [
	^ operatingSystem
]

{ #category : #accessing }
Workload >> operatingSystem: aString [
	operatingSystem := aString
]

{ #category : #accessing }
Workload >> operatingSystemDetail [
	^ operatingSystemDetail
]

{ #category : #accessing }
Workload >> operatingSystemDetail: aString [
	operatingSystemDetail := aString
]

{ #category : #accessing }
Workload >> role [
	^ role
]

{ #category : #accessing }
Workload >> role: aString [
	role := aString
]
