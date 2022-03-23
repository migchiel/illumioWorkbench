"
I represent a illumio Demo environment in which one or more demo scripts are defined.
"
Class {
	#name : #IllumioDemo,
	#superclass : #Object,
	#instVars : [
		'environments',
		'roles',
		'applications',
		'locations',
		'workloads',
		'flows',
		'iplists'
	],
	#classInstVars : [
		'labels'
	],
	#category : #'illumioWorkbench-Base'
}

{ #category : #accessing }
IllumioDemo >> addApplication: anApplication [
	environments add: anApplication environment.
	locations add: anApplication location.
	applications add: anApplication name 
]

{ #category : #accessing }
IllumioDemo >> addEnvironment: anEnvironment [
	environments add: anEnvironment
]

{ #category : #accessing }
IllumioDemo >> addIPList: anIPList [
	iplists add: anIPList
]

{ #category : #accessing }
IllumioDemo >> addLocation: aLocation [ 
	locations add: aLocation
]

{ #category : #accessing }
IllumioDemo >> addWorkload: aWorkload [
	roles add: aWorkload role.
	applications add: aWorkload application.
	environments add: aWorkload environment.
	locations add: aWorkload location.
	workloads add: aWorkload
]

{ #category : #accessing }
IllumioDemo >> addWorkload: aWorkload toApplication: anApplication [
	aWorkload ael: anApplication.
	workloads add: aWorkload
]

{ #category : #'as yet unclassified' }
IllumioDemo >> createFlows: anAddressCollection [ 
	1000 timesRepeat: [ 
		flows add: (Flow new src: anAddressCollection atRandom;dst: anAddressCollection atRandom;port: #('80' '443' '137' '138' '389' '22' '88' '53' '3389' '502') atRandom;proto: ({'UDP' . 'TCP'} atRandom))
	]
]

{ #category : #'as yet unclassified' }
IllumioDemo >> createFlows: anAddressCollection count: aCount [
	aCount timesRepeat: [ 
		flows add: (Flow new src: anAddressCollection atRandom;dst: anAddressCollection atRandom;port: #('80' '443' '137' '138' '389' '22' '88' '53' '3389') atRandom;proto: 'TCP')
	]
]

{ #category : #'as yet unclassified' }
IllumioDemo >> createFlows: aCount from: aConsumerCollection to: aProviderCollection withServices: aServiceCollection andProtocol: aProtocol [
	aCount timesRepeat: [ 
		flows add: (Flow new src: aConsumerCollection atRandom ipAddresses atRandom;
		                     dst: aProviderCollection atRandom ipAddresses atRandom;
		                     port: aServiceCollection atRandom;
		                     proto: aProtocol)
	]
]

{ #category : #'as yet unclassified' }
IllumioDemo >> createFlows: anAddressCollection targetIP: anIPAddress services: aListOfServices [
	1000 timesRepeat: [ 
		flows add: (Flow new src: anAddressCollection atRandom;dst: anIPAddress;port: aListOfServices atRandom;proto: 'TCP')
	]
]

{ #category : #accessing }
IllumioDemo >> flows [
	^ flows
]

{ #category : #'as yet unclassified' }
IllumioDemo >> getApplicationWorkloadsFor: anApplication [
	^ self workloads select: [ :each | each application = anApplication ].
]

{ #category : #'as yet unclassified' }
IllumioDemo >> getWorkloadsFor: aLabelCollection [
	^ self workloads select: [ :each | aLabelCollection contains: each application ].
]

{ #category : #initialization }
IllumioDemo >> initialize [ 
	roles := Set new.
	applications := Set new.
	environments := Set new.
	locations := Set new.
	workloads := Set new.
	flows := Set new.
	iplists := Set new.
]

{ #category : #accessing }
IllumioDemo >> iplists [
	^ iplists
]

{ #category : #accessing }
IllumioDemo >> workloads [
	^ workloads
]

{ #category : #accessing }
IllumioDemo >> workloads: anObject [
	workloads := anObject
]
