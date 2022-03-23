Class {
	#name : #ILRESTRuleSet,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #accessing }
ILRESTRuleSet >> getRules [

	^ ((self valueAt: #rules) collect: [ :each | 
		   ILRESTRules new properties: each ]) asSet
	
]

{ #category : #initialization }
ILRESTRuleSet >> initialize [

	super initialize.
	self itemUrl: 'sec_policy/draft/rule_sets'
]

{ #category : #initialization }
ILRESTRuleSet >> name [ 

	^ self valueAt: #name
]

{ #category : #initialization }
ILRESTRuleSet >> name: aName [

	^ self valueAt: #name put: aName
]

{ #category : #accessing }
ILRESTRuleSet >> rules [

	^ ((self valueAt: #nodes) collect: [ :each | 
		   ILRESTContainerClusterNode new properties: each ]) asSet
]
