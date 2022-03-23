Class {
	#name : #ILRESTLabelGroup,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTLabelGroup >> initialize [

	super initialize.
	self itemUrl: 'sec_policy/draft/label_groups'
]
