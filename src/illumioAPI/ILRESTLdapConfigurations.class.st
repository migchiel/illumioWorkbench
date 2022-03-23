Class {
	#name : #ILRESTLdapConfigurations,
	#superclass : #ILRESTRoot,
	#category : #'illumioAPI-Root'
}

{ #category : #initialization }
ILRESTLdapConfigurations >> initialize [

	super initialize.
	self itemUrl: 'authentication_settings/ldap_configs'
]
