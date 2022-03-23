Class {
	#name : #ILRESTSyslogDestination,
	#superclass : #ILRESTOrg,
	#category : #'illumioAPI-Org'
}

{ #category : #initialization }
ILRESTSyslogDestination >> initialize [

	super initialize.
	self itemUrl: 'settings/syslog/destinations'
]
