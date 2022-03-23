Class {
	#name : #ILRESTConnection,
	#superclass : #Object,
	#traits : 'ILRESTRequest',
	#classTraits : 'ILRESTRequest classTrait',
	#instVars : [
		'url',
		'apiKeyID',
		'apiSecret',
		'apiVersion',
		'org'
	],
	#category : #'illumioAPI-Core'
}

{ #category : #accessing }
ILRESTConnection class >> connectTo: aPCE [

	^ self basicNew
		  initializeConnection: aPCE;
		  initialize;
		  yourself
]

{ #category : #accessing }
ILRESTConnection class >> getDefinedPCES [

	| connections |
	connections := PPYAMLGrammar new parse:
		               'pce.yaml' asFileReference contents.
	^ (connections select: [ :conn | conn isDictionary ]) collect: [ :pce | pce at: 'fqdn' ]
]

{ #category : #accessing }
ILRESTConnection class >> new [

	^ self error: 'Use #connect: <pce url>'
]

{ #category : #accessing }
ILRESTConnection >> apiKeyID [

	^ apiKeyID
]

{ #category : #accessing }
ILRESTConnection >> apiKeyID: anObject [

	apiKeyID := anObject
]

{ #category : #accessing }
ILRESTConnection >> apiSecret [

	^ apiSecret
]

{ #category : #accessing }
ILRESTConnection >> apiSecret: anObject [

	apiSecret := anObject
]

{ #category : #accessing }
ILRESTConnection >> apiVersion [

	^ apiVersion
]

{ #category : #'accessing - backend' }
ILRESTConnection >> connect [

	"
	| username password |
	username := UIManager default request: 'Enter your PCE user name'.
	username ifNotNil: [ 
		password := UIManager default requestPassword:
			            'Enter your PCE password'.
		password ifNotNil: [ 
			Transcript
				clear;
				show:
					'All was fine. Username: ' , username , ' with password: '
					, password;
				cr ] ].
"
]

{ #category : #'accessing - backend' }
ILRESTConnection >> createIPList: anIPList [

	^ ILRESTIpList new
		  connection: self;
		  properties: (anIPList
				   pce: self;
				   create)
]

{ #category : #'accessing - backend' }
ILRESTConnection >> createWorkload: aWorkload [

	^ ILRESTWorkload new
		  connection: self;
		  properties: (aWorkload
				   pce: self;
				   create)
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getAccessRestrictions [

	^ (ILRESTAccessRestrictions new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getAllRules [

	| allRules |
	allRules := Set new.
	self getRuleSets do: [ :i | 
		allRules add: (ILRESTRuleSet new pce: self) getItems ]
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getApplicationGroups [

	^ (ILRESTApplicationGroup new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getApplicationLabels [

	^ self getLabelDimension: #app
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getAuthSecurityPrincipals [

	^ (ILRESTAuthSecurityPrincipal new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getAuthenticationSettings [

	^ self getDict: ILRESTAuthenticationSettings
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getContainerCluster [

	^ (ILRESTContainerCluster new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getCoreServiceTypes [

	^ (ILRESTCoreServiceType new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getDetectedCoreServices [

	^ (ILRESTDetectedCoreService new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getDict: anItem [

	| result |
	result := anItem new
		          pce: self;
		          getAll.
	^ anItem new
		  properties: result;
		  pce: self
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getEnvironmentLabels [

	^ self getLabelDimension: #env
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getEvents [

	^ (ILRESTSystemEvent new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getIpLists [

	^ (ILRESTIpList new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getItem: anItem [

	| result |
	result := anItem new
		          pce: self;
		          getAll.
	^ anItem new
		  properties: (result at: 1);
		  pce: self
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getLabelDimension: aDimension [

	^ self getLabels select: [ :each | each key = aDimension ]
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getLabelGroups [

	^ (ILRESTLabelGroup new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getLabels [

	^ (ILRESTLabel new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getLdapConfigurations [

	^ (ILRESTLdapConfigurations new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getLicences [

	^ (ILRESTLicense new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getLoadBalancers [

	^ (ILRESTLoadBalancers new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getLocationLabels [

	^ self getLabelDimension: #loc
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getPasswordPolicy [

	^ self getDict: ILRESTPasswordPolicy 
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getPce [

	^ self getItem: ILRESTPceHealth
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getProductVersion [

	^ self getDict: ILRESTProductVersion
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getRoleLabels [

	^ self getLabelDimension: #role
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getRuleSets [

	^ (ILRESTRuleSet new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getSecurityPolicies [

	^ (ILRESTSecurityPolicy new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getSecurityPrincipals [

	^ (ILRESTSecurityPrincipal new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getServiceBindings [

	^ (ILRESTServiceBinding new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getServices [

	^ (ILRESTService new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getSyslogSettings [

	^ (ILRESTSyslogDestination new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getTrafficCollectorSettings [

	^ (ILRESTTrafficCollector new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getTrustedProxyIPS [

	^ self getDict: ILRESTTrustedProxy
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getUsers [

	^ (ILRESTUser new pce: self) getItems
]

{ #category : #'accessing - backend' }
ILRESTConnection >> getWorkloads [

	^ (ILRESTWorkload new pce: self) getItems
]

{ #category : #initialization }
ILRESTConnection >> initialize [
	apiVersion := 'v2'


	
]

{ #category : #initialization }
ILRESTConnection >> initializeConnection: aPCE [

	| connections connectionProperties |
	connections := PPYAMLGrammar new parse:
		               'pce.yaml' asFileReference contents.

	connectionProperties := connections at: aPCE.
	self apiSecret: (connectionProperties at: 'key').
	self apiKeyID: (connectionProperties at: 'user').
	self url: 'https://' , (connectionProperties at: 'fqdn') , ':'
		, (connectionProperties at: 'port').
	self org: (connectionProperties at: 'org')
]

{ #category : #accessing }
ILRESTConnection >> org [

	^ org
]

{ #category : #accessing }
ILRESTConnection >> org: aOrg [

	org := aOrg
]

{ #category : #accessing }
ILRESTConnection >> url [

	^ url
]

{ #category : #accessing }
ILRESTConnection >> url: aUrl [

	url := aUrl 
]
