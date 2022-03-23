Class {
	#name : #ILRESTContainerCluster,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Root'
}

{ #category : #accessing }
ILRESTContainerCluster >> containerRuntime [

	^ self valueAt: #container_runtime
]

{ #category : #accessing }
ILRESTContainerCluster >> description [

	^ self valueAt: #description
]

{ #category : #initialization }
ILRESTContainerCluster >> initialize [

	super initialize.
	self itemUrl: #container_clusters
]

{ #category : #accessing }
ILRESTContainerCluster >> kubelinkVersion [

	^ self valueAt: #kubelink_version
]

{ #category : #accessing }
ILRESTContainerCluster >> lastConnected [

	^ self valueAt: #last_connected
]

{ #category : #accessing }
ILRESTContainerCluster >> managerType [

	^ self valueAt: #manager_type
]

{ #category : #accessing }
ILRESTContainerCluster >> name [

	^ self valueAt: #name
]

{ #category : #accessing }
ILRESTContainerCluster >> nodes [

	^ ((self valueAt: #nodes) collect: [ :each | 
		   ILRESTContainerClusterNode  new
			   properties: each]) asSet
]

{ #category : #accessing }
ILRESTContainerCluster >> online [

	^ self valueAt: #online
]
