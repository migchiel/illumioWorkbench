"
I represent a Subnet with all the relevant information such as start and end ip address, broadcast address, ip space size etc.
"
Class {
	#name : #Subnet,
	#superclass : #Object,
	#instVars : [
		'cidr',
		'majorNetwork',
		'mask',
		'first',
		'last',
		'broadcast',
		'usableHosts'
	],
	#category : #'illumioWorkbench-Utils'
}

{ #category : #'instance creation' }
Subnet class >> new: aCIDR [
	^ self new cidr: aCIDR 
]

{ #category : #accessing }
Subnet >> baseAddress [
	| majorAddress offset |
	
	offset := self offset.
	majorAddress := self convertIPToInteger: majorNetwork.
	^ majorAddress >> offset << offset

]

{ #category : #accessing }
Subnet >> broadcast [
	^ self integerToIPString: (self baseAddress + 1 + usableHosts)
]

{ #category : #calculations }
Subnet >> calculatePool [
	| items |

	items := cidr splitOn: '/'.
	majorNetwork := items at: 1.
	mask := items at: 2.
	usableHosts := self usableHosts.
	first := self firstIP.
	last := self lastIP.
	broadcast := self broadcast.
	

	
]

{ #category : #accessing }
Subnet >> cidr [
	^ cidr
]

{ #category : #accessing }
Subnet >> cidr: anCIDR [
	cidr := anCIDR.
	self calculatePool
]

{ #category : #converting }
Subnet >> convertIPToInteger: anAddress [
	| quartet output |
	
	quartet := SocketAddress fromDottedString: anAddress.
	output := quartet at: 1.
	output := output << 8 + (quartet at: 2).
	output := output << 8 + (quartet at: 3).
	output := output << 8 + (quartet at: 4).
	^ output
]

{ #category : #accessing }
Subnet >> first [
	^ first
]

{ #category : #accessing }
Subnet >> first: anIPAddress [
	first := anIPAddress 
]

{ #category : #converting }
Subnet >> firstAsInteger [
	^ self convertIPToInteger: first.
]

{ #category : #accessing }
Subnet >> firstIP [
	^ self integerToIPString: (self baseAddress + 1)
]

{ #category : #converting }
Subnet >> integerToIPString: anInteger [
	^ (anInteger byteAt: 4) asString , '.', (anInteger byteAt: 3) asString , '.', (anInteger byteAt: 2) asString , '.', (anInteger byteAt: 1) asString
]

{ #category : #accessing }
Subnet >> last [
	^ last
]

{ #category : #accessing }
Subnet >> last: anIPAddress [
	last := anIPAddress
]

{ #category : #accessing }
Subnet >> lastIP [
	^ self integerToIPString: (self baseAddress + usableHosts)
]

{ #category : #accessing }
Subnet >> majorAddress [
	^ self convertIPToInteger: majorNetwork
]

{ #category : #accessing }
Subnet >> offset [
	^ 32 - mask asNumber.

]

{ #category : #random }
Subnet >> randomIP [
	^ self integerToIPString: (self baseAddress + usableHosts atRandom)
]

{ #category : #accessing }
Subnet >> usableHosts [
	^ 2 ** (self offset) - 2
]
