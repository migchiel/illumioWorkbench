Class {
	#name : #ILRESTPasswordPolicy,
	#superclass : #ILRESTRoot,
	#category : #'illumioAPI-Root'
}

{ #category : #'as yet unclassified' }
ILRESTPasswordPolicy >> expireDays [

	^ self valueAt: #expire_time_days
]

{ #category : #'as yet unclassified' }
ILRESTPasswordPolicy >> historyCount [

	^ self valueAt: #history_count
]

{ #category : #initialization }
ILRESTPasswordPolicy >> initialize [

	super initialize.
	self itemUrl: 'authentication_settings/password_policy'
]

{ #category : #'as yet unclassified' }
ILRESTPasswordPolicy >> minimumCharsPerType [

	^ self valueAt: #min_characters_per_type
]

{ #category : #'as yet unclassified' }
ILRESTPasswordPolicy >> minimumCharsToChange [

	^ self valueAt: #min_changed_characters
]

{ #category : #'as yet unclassified' }
ILRESTPasswordPolicy >> minimumLength [

	^ self valueAt: #min_length
]

{ #category : #'as yet unclassified' }
ILRESTPasswordPolicy >> requireLowercase [

	^ self valueAt: #require_type_lowercase


]

{ #category : #'as yet unclassified' }
ILRESTPasswordPolicy >> requireNumber [

	^ self valueAt: #require_type_number
]

{ #category : #'as yet unclassified' }
ILRESTPasswordPolicy >> requireSymbol [

	^ self valueAt: #require_type_symbol
]

{ #category : #'as yet unclassified' }
ILRESTPasswordPolicy >> requireUppercase [

	^ self valueAt: #require_type_uppercase
]

{ #category : #'as yet unclassified' }
ILRESTPasswordPolicy >> sessionTimeoutMinutes [

	^ self valueAt: #session_timeout_minutes
]
