"
I represent a DHCPServer. I can provide dhcp leases in 1 or more subnets.
"
Class {
	#name : #DHCPServer,
	#superclass : #Object,
	#instVars : [
		'pools',
		'leases',
		'addresses'
	],
	#category : #'illumioWorkbench-Utils'
}

{ #category : #initialization }
DHCPServer >> addRange: aName cidr: aCIDR [
	| subnet |
	subnet := Subnet new: aCIDR.
	pools at: aName put: subnet.
	^ self
]

{ #category : #accessing }
DHCPServer >> addresses [
	^ addresses
]

{ #category : #'as yet unclassified' }
DHCPServer >> getLease: aSubnet [
	| subnet ip |
	
	subnet := self getSubnet: aSubnet.
	ip := subnet randomIP.
	addresses add: ip.
	^ ip
	
	
]

{ #category : #'as yet unclassified' }
DHCPServer >> getSubnet: aSubnet [
	^ pools at: aSubnet
]

{ #category : #initialization }
DHCPServer >> initialize [ 
	pools := Dictionary new.
	leases := Dictionary new.
	addresses := Set new.
]

{ #category : #accessing }
DHCPServer >> pools [
	^ pools
]

{ #category : #'as yet unclassified' }
DHCPServer >> randomSubnet [
	^ pools keys atRandom 
]
