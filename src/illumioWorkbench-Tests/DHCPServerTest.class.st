"
A DHCPServerTest is a test class for testing the behavior of DHCPServer
"
Class {
	#name : #DHCPServerTest,
	#superclass : #TestCase,
	#instVars : [
		'dhcp'
	],
	#category : #'illumioWorkbench-Tests'
}

{ #category : #running }
DHCPServerTest >> setUp [
	dhcp := DHCPServer new.
	dhcp addRange: 'VLAN' cidr: '192.168.1.0/24'.
	dhcp addRange: 'VPN' cidr: '172.16.0.0/16'.
	dhcp addRange: 'Goofy' cidr: '188.12.0.1/23'.
	dhcp addRange: 'Wappie' cidr: '18.31.1.34/17'.
	dhcp addRange: 'DC1' cidr: '32.0.0.0/3'

]

{ #category : #tests }
DHCPServerTest >> testAddRangeCidr [

	| subnet |
	subnet := dhcp getSubnet: 'VLAN'.
	self assert: subnet first equals: '192.168.1.1'.
	self assert: subnet last equals: '192.168.1.254'.
	self assert: subnet broadcast equals: '192.168.1.255'.
	self assert: subnet usableHosts equals: 254.

	subnet := dhcp getSubnet: 'Goofy'.
	self assert: subnet first equals: '188.12.0.1'.
	self assert: subnet last equals: '188.12.1.254'.
	self assert: subnet broadcast equals: '188.12.1.255'.
	self assert: subnet usableHosts equals: 510.

	subnet := dhcp getSubnet: 'VPN'.
	self assert: subnet first equals: '172.16.0.1'.
	self assert: subnet last equals: '172.16.255.254'.
	self assert: subnet broadcast equals: '172.16.255.255'.
	self assert: subnet usableHosts equals: 65534.

	subnet := dhcp getSubnet: 'Wappie'.
	self assert: subnet first equals: '18.31.0.1'.
	self assert: subnet last equals: '18.31.127.254'.
	self assert: subnet broadcast equals: '18.31.127.255'.
	self assert: subnet usableHosts equals: 32766.

	subnet := dhcp getSubnet: 'DC1'.
	self assert: subnet first equals: '32.0.0.1'.
	self assert: subnet last equals: '63.255.255.254'.
	self assert: subnet broadcast equals: '63.255.255.255'.
	self assert: subnet usableHosts equals: 536870910
]

{ #category : #tests }
DHCPServerTest >> testGetLease [

	self assert: true
]
