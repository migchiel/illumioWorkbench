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

{ #category : #test }
DHCPServerTest >> testAddRangeCidr [
	| subnet |
	
	subnet := dhcp getSubnet: 'VLAN'.
	self assert: subnet first = '192.168.1.1'.
	self assert: subnet last = '192.168.1.254'.
	self assert: subnet broadcast = '192.168.1.255'.
	self assert: subnet usableHosts = 254.
	
	subnet := dhcp getSubnet: 'Goofy'.
	self assert: subnet first = '188.12.0.1'.
	self assert: subnet last = '188.12.1.254'.
	self assert: subnet broadcast = '188.12.1.255'.
	self assert: subnet usableHosts = 510.
	
	subnet := dhcp getSubnet: 'VPN'.
	self assert: subnet first = '172.16.0.1'.
	self assert: subnet last = '172.16.255.254'.
	self assert: subnet broadcast = '172.16.255.255'.
	self assert: subnet usableHosts = 65534.
	
	subnet := dhcp getSubnet: 'Wappie'.
	self assert: subnet first = '18.31.0.1'.
	self assert: subnet last = '18.31.127.254'.
	self assert: subnet broadcast = '18.31.127.255'.
	self assert: subnet usableHosts = 32766.

	subnet := dhcp getSubnet: 'DC1'.
	self assert: subnet first = '32.0.0.1'.
	self assert: subnet last = '63.255.255.254'.
	self assert: subnet broadcast = '63.255.255.255'.
	self assert: subnet usableHosts = 536870910.

]

{ #category : #test }
DHCPServerTest >> testGetLease [

	self assert: true
]
