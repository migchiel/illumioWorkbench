"
A WorkloadTest is a test class for testing the behavior of Workload
"
Class {
	#name : #WorkloadTest,
	#superclass : #TestCase,
	#instVars : [
		'workload'
	],
	#category : #'illumioWorkbench-Tests'
}

{ #category : #running }
WorkloadTest >> setUp [
	workload := Workload new.

]

{ #category : #tests }
WorkloadTest >> testInterfaceName [

	self assert: workload interfaceName equals: 'eth'.
	workload interfaceName: 'iface0'.
	self assert: workload interfaceName equals: 'iface0'
]

{ #category : #test }
WorkloadTest >> testInterfacesAsString [

	workload addIPAddress: '192.168.1.1'.
	self assert: [ workload interfacesAsString = 'eth0:192.168.1.1' ].

	workload interfaceName: 'en'.
	self assert: [ workload interfacesAsString = 'en0:192.168.1.1' ].

	workload addIPAddress: '192.168.1.2'.
	self assert: [ 
		workload interfacesAsString = 'en0:192.168.1.1;en1:192.168.1.2' ]
]
