Class {
	#name : #ILRESTContainerClusterNode,
	#superclass : #ILRESTBase,
	#category : #'illumioAPI-Helper'
}

{ #category : #accessing }
ILRESTContainerClusterNode >> name [ 

	^ self valueAt: #name
]

{ #category : #accessing }
ILRESTContainerClusterNode >> podSubnet [

	^ self valueAt: #pod_subnet
]
