Class {
	#name : #ILRESTEssentialServiceRules,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #accessing }
ILRESTEssentialServiceRules >> getRules [

	^ ((self valueAt: #rules) collect: [ :each | 
		   ILRESTRules new properties: each ]) asSet
]

{ #category : #initialization }
ILRESTEssentialServiceRules >> initialize [

	super initialize.
	self itemUrl: 'sec_policy/draft/essential_service_rules'
]
