"
I represent a DemoScript targetting an illumio PCE to demonstrate some use case or other capability of illumio Core

"
Class {
	#name : #DemoScript,
	#superclass : #Object,
	#instVars : [
		'demoHelper'
	],
	#category : #'illumioWorkbench-Base'
}

{ #category : #script }
DemoScript >> basicDemo [

	<script: 'self new basicDemo'>
	| demo workload application workloader hostname |
	demo := IllumioDemo new.

	workload := Workload new
		            name: 'Host-2';
		            role: demoHelper randomRole;
		            application: 'HRM';
		            environment: 'PROD';
		            location: demoHelper randomLocation.

	demo addWorkload: workload.

	application := Application new
		               name: 'POS';
		               environment: 'UAT';
		               location: demoHelper randomLocation.

	demo addApplication: application.

	demo
		addWorkload: (Workload new
				 name: 'host-13';
				 role: demoHelper randomRole)
		toApplication: application.
	demo
		addWorkload: (Workload new
				 name: 'host-25';
				 role: demoHelper randomRole)
		toApplication: application.
	demo
		addWorkload: (Workload new
				 name: 'host-252';
				 role: demoHelper randomRole)
		toApplication: application.

	hostname := HostnameGenerator new.

	1 to: 100 do: [ :i | 
		application := Application new
			               name: demoHelper randomApplication;
			               environment: demoHelper randomEnvironment;
			               location: demoHelper randomLocation.
		demo
			addWorkload: (Workload new
					 name: hostname generateName;
					 role: demoHelper randomRole)
			toApplication: application ].

	workloader := WorkloaderWrapper new.
	workloader importWorkloads: demo workloads
]

{ #category : #script }
DemoScript >> cleanUp [ 
<script: 'self new cleanUp'>
WorkloaderWrapper new cleanup
]

{ #category : #script }
DemoScript >> demo6 [

	<script: 'self new demo6'>
	| workloader demo dhcp consumers providers appWorkloads |
	"Create a new demo environment"
	demo := IllumioDemo new.

	"Create the set of IP lists for the demo environment"
	demo addIPList: (IPList new
			 name: 'External';
			 include: '0.0.0.0';
			 exclude: '10.0.8.0/24;77.167.57.28').
	demo addIPList: (IPList new
			 name: 'VPN';
			 include: '192.168.1.0/24').
	demo addIPList: (IPList new
			 name: 'RFC1918';
			 include: '192.168.0.0/16;172.16.0.0/12;10.0.0.0/8').
	demo addIPList: (IPList new
			 name: 'Core Services';
			 include: '192.168.4.0/24').

	"Create a collection of workloads based on the demo6 export"
	demo workloads: demoHelper demo6Workloads.

	"Create a DHCP server for this demo environment providing DHCP leases for 4 VLAN's and also setup a core services range"
	dhcp := DHCPServer new.
	dhcp
		addRange: 'VLAN1' cidr: '192.168.3.0/24';
		addRange: 'VLAN3' cidr: '172.20.0.0/20';
		addRange: 'VLAN23' cidr: '172.30.0.0/18'.

	"Assign the workloads random ip address from the above ranges"
	demo workloads do: [ :wl | 
		wl addIPAddress: (dhcp getLease: dhcp randomSubnet) ].

	"Add an extra subnet for the core services. I am adding this subnet after the address are dished out to the workloads"
	"using the already defined subnets to avoid regular workloads getting an IP address in the core services range"
	dhcp addRange: 'Core Services' cidr: '192.168.4.0/24'.

	"Use workloader to import the workloads generated above into the illumio PCE"
	workloader := WorkloaderWrapper new.
	workloader importWorkloads: demo workloads.

	"Use workloader to import the iplists created earlier"
	workloader importIPLists: demo iplists.

	"Get all the workoads that are part of the point of sale application"
	appWorkloads := demo getApplicationWorkloadsFor: 'Point-of-Sale'.

	"Get the Web and Processing workloads as consumer and provider collections respectively"
	consumers := appWorkloads select: [ :each | each role = 'Web' ].
	providers := appWorkloads select: [ :each | each role = 'Processing' ].

	"'Connect' the Web tier to the processing tier, accross locations"
	demo
		createFlows: 100
		from: consumers
		to: providers
		withServices: #( '8070' )
		andProtocol: 'TCP'.

	"Make the Processing tier the consumer"
	consumers := providers.

	"Get the Database roles as the providers"
	providers := appWorkloads select: [ :each | each role = 'Database' ].

	"'Connect' the Processing tier to the Database tier, accross locations"
	demo
		createFlows: 300
		from: consumers
		to: providers
		withServices: #( '1433' )
		andProtocol: 'TCP'.

	"Create some core services flows "
	"Let's do AD flows first. Create 10 AD servers with random IP address in the Core Services range"
	"First, let's create a new Set to hold the providers"
	providers := Set new.

	10 timesRepeat: [ 
		providers add:
			(Workload new addIPAddress: (dhcp getLease: 'Core Services')) ].
	consumers := demo workloads.

	"Now create the typical AD server flows"
	demo
		createFlows: 3000
		from: consumers
		to: providers
		withServices: #( '5355' '123' )
		andProtocol: 'UDP'.
	demo
		createFlows: 1300
		from: consumers
		to: providers
		withServices: #( '88' '135' '49152' '50121' )
		andProtocol: 'TCP'.
	demo
		createFlows: 2200
		from: consumers
		to: providers
		withServices: #( '445' '137' '138' '139' '389' '464' '53' )
		andProtocol: { 'UDP'. 'TCP' } atRandom.

	"Let's create some system management and other core services flows such as NFS, SYSLOG"
	"First, let's empty the Set to hold the providers"
	providers removeAll.

	"Now let's create the actual core services flows"
	4 timesRepeat: [ 
		providers add:
			(Workload new addIPAddress: (dhcp getLease: 'Core Services')) ].
	demo
		createFlows: 900
		from: consumers
		to: providers
		withServices: #( '2049' '514' )
		andProtocol: 'UDP'.

	"Let's create some system management and other core services flows such as SNMP, POPv3, POPv3S, Kerberos login"
	"First, let's clear the current set of providers"
	providers removeAll.

	"Now let's create the actual core services flows"
	14 timesRepeat: [ 
		providers add:
			(Workload new addIPAddress: (dhcp getLease: 'Core Services')) ].
	demo
		createFlows: 100
		from: consumers
		to: providers
		withServices: #( '161' '110' '995' '543' )
		andProtocol: 'TCP'.

	"Use workloader to import all the flows previously generated"
	workloader importFlows: demo flows
]

{ #category : #script }
DemoScript >> demo6Label [

	<script: 'self new demo6Label'>
	| workloader demo |
	"Create a new demo environment"
	demo := IllumioDemo new.
	demo workloads: demoHelper demo6Workloads.

	"Use workloader to import the workloads generated above into the illumio PCE"
	workloader := WorkloaderWrapper new.
	workloader importWorkloads: demo workloads
]

{ #category : #script }
DemoScript >> demo6RedPasta [

	<script: 'self new demo6RedPasta'>
	| workloader demo dhcp application |
	"Create a new demo environment"
	demo := IllumioDemo new.

	"Create the set of IP lists for the demo environment"
	demo addIPList: (IPList new
			 name: 'External';
			 include: '0.0.0.0';
			 exclude: '10.0.8.0/24;77.167.57.28').
	demo addIPList: (IPList new
			 name: 'VPN';
			 include: '192.168.1.0/24').
	demo addIPList: (IPList new
			 name: 'RFC1918';
			 include: '192.168.0.0/16;172.16.0.0/12;10.0.0.0/8').
	demo addIPList: (IPList new
			 name: 'Core Services';
			 include: '192.168.4.0/24').

	application := Application new
		               name: 'NoApp';
		               environment: 'NoEnv';
		               location: 'NoLoc'.
	demoHelper demo6Workloads do: [ :wkld | 
		demo addWorkload: (wkld role: '') toApplication: application ].


	"Create a DHCP server for this demo environment providing DHCP leases for 3 VLAN's and also setup a core services range"
	dhcp := DHCPServer new.
	dhcp
		addRange: 'VLAN1' cidr: '192.168.3.0/24';
		addRange: 'VLAN3' cidr: '172.20.0.0/20';
		addRange: 'VLAN23' cidr: '172.30.0.0/18'.

	"Assign the workloads random ip address from the above ranges"
	demo workloads do: [ :wl | 
		wl addIPAddress: (dhcp getLease: dhcp randomSubnet) ].

	"Add an extra subnet for the core services. I am adding this subnet after the address are dished out to the workloads"
	"using the already defined subnets to avoid regular workloads getting an IP address in the core services range"
	dhcp addRange: 'Core Services' cidr: '192.168.4.0/24'.

	"Use workloader to import the workloads generated above into the illumio PCE"
	workloader := WorkloaderWrapper new.
	workloader importWorkloads: demo workloads.

	"Use workloader to import the iplists created earlier"
	workloader importIPLists: demo iplists.

	demo createFlows: dhcp addresses count: 500.
	"Use workloader to import the flows into a PCE"
	workloader importFlows: demo flows
]

{ #category : #script }
DemoScript >> initialize [
	demoHelper := DemoUtils new.

	
]

{ #category : #script }
DemoScript >> iot [

	<script: 'self new iot'>
	| demo workloader dhcp hostname |
	"Create a new demo environment"
	demo := IllumioDemo new.
	"Create a DHCP server for this demo environment providing DHCP leases for 4 VLAN's"
	dhcp := DHCPServer new.
	dhcp
		addRange: 'VLAN-OT-SENSORS' cidr: '192.168.1.0/24';
		addRange: 'VLAN-IT' cidr: '192.168.2.0/24';
		addRange: 'VLAN-OT-ACTUATORS' cidr: '172.30.0.0/18'.

	demo addIPList: (IPList new
			 name: 'VLAN-OT-SENSORS';
			 include: '192.168.1.0/24').
	demo addIPList: (IPList new
			 name: 'VLAN-IT';
			 include: '192.168.2.0/24').
	demo addIPList: (IPList new
			 name: 'VLAN-OT-ACTUATORS';
			 include: '172.30.0.0/18').


	"Create 10 sensors and 10 actuators in the respective VLANS"
	10 timesRepeat: [ 
		dhcp getLease: 'VLAN-OT-SENSORS'.
		dhcp getLease: 'VLAN-OT-ACTUATORS' ].

	"Generate 10 controller unmanaged workloads"
	hostname := HostnameGenerator new.
	200 timesRepeat: [ 
		demo addWorkload: (Workload new
				 name: hostname generateName;
				 role: 'R: IOT Controller';
				 application: 'A: Factory control';
				 environment: 'E: Production';
				 location:
					 'L: '
					 , { 'Site1'. 'Site2'. 'Site3'. 'Site3'. 'Main Site' } atRandom;
				 addIPAddress: (dhcp getLease: 'VLAN-IT')) ].

	demo createFlows: dhcp addresses.
	workloader := WorkloaderWrapper new.
	"Use workloader to import the iplists created earlier"
	workloader importIPLists: demo iplists.
	"Use the workloader wrapper to import the workloads as CSV"
	workloader importWorkloads: demo workloads.
	"Use the workloader wrapper to import the flows as CSV"
	workloader importFlows: demo flows
	"workloader exportFlowsAsCsv: demo flows."
]

{ #category : #script }
DemoScript >> scaleTest [

	<script: 'self new scaleTest'>
	| demo application hostname dhcp |
	demo := IllumioDemo new.

	hostname := HostnameGenerator new.

	dhcp := DHCPServer new addRange: 'VLAN23' cidr: '10.0.0.0/8'.

	1 to: 800000 do: [ :i | 
		demo addWorkload: (Workload new
				 name: hostname generateName;
				 role: demoHelper randomRole;
				 environment: demoHelper randomEnvironment;
				 location: demoHelper randomLocation;
				 application: demoHelper randomApplication;
				 operatingSystemDetail: demoHelper randomOSDetail;
				 operatingSystem: demoHelper randomOS;
				 addIPAddress: (dhcp getLease: dhcp randomSubnet)) ].

	demo inspect
]

{ #category : #script }
DemoScript >> script1: wls [

	<script: 'self new script1: 25'>
	| demo workload application workloader nameGenerator dhcp |
	"Create a new demo environment"
	demo := IllumioDemo new.

	"Create a DHCP server for this demo environment providing DHCP leases for 4 VLAN's"
	dhcp := DHCPServer new.
	dhcp
		addRange: 'VLAN1' cidr: '172.16.0.0/16';
		addRange: 'VLAN3' cidr: '172.20.0.0/20';
		addRange: 'VLAN23' cidr: '172.30.0.0/18';
		addRange: 'VPN' cidr: '10.0.0.0/8'.


	"Create a hostname generator instance so we can request random hostnames for our workloads"
	"The generated host names are not scrubbed for policital correctness"
	nameGenerator := HostnameGenerator new.

	"Create an application, at random, and add a workload to it. The wls parameter passed into this script controls how many workloads will be created in total"
	wls timesRepeat: [ 
		application := Application new
			               name:
				               { 'A: SWIFT'. 'A: POS'. 'A: CRM'. 'A: HRM' }
					               atRandom;
			               environment:
				               { 'E: TST'. 'E: PROD'. 'E: DEV'. 'E: PCI'. 'E: STAGING'.
				               'E: SWIFT' } atRandom;
			               location:
				               { 'L: AWS'. 'L: Azure'. 'L: New York'. 'L: Paris'.
				               'L: Reinosathe'. 'L: London' } atRandom.

		workload := Workload new
			            name: nameGenerator generateName;
			            role:
				            { 'R: DB'. 'R: WEB'. 'R: APP'. 'R: API'. 'R: PROC'.
				            'R: DB-PRIMARY'. 'R: DB-SECONDARY' } atRandom;
			            operatingSystem: demoHelper randomOS;
			            operatingSystemDetail: demoHelper randomOSDetail.
		"Add 1 - 4 network adapters and associated an IP address with it from a randomly chosen DHCP pool on our DHCP server"
		4 atRandom timesRepeat: [ 
			workload addIPAddress: (dhcp getLease: dhcp randomSubnet) ].
		"Add the workload to the previously created application"
		demo addWorkload: workload toApplication: application ].

	"Use workloader to import the workloads generated above into the illumio PCE"
	workloader := WorkloaderWrapper new.
	workloader importWorkloads: demo workloads.

	"Give the PCE some time to catch up"
	(Delay forSeconds: 10) wait.

	"Based on the leases generated in the workload creation process, create random flows for some known services between the workloads using TCP and UDP"
	demo createFlows: dhcp addresses.
	workloader importFlows: demo flows
]

{ #category : #script }
DemoScript >> script2 [
<script: 'self new script2'>
| demo workloader dhcp hostname |

"Create a new demo environment"
demo := IllumioDemo new.

hostname := HostnameGenerator new.

"Create a DHCP server for this demo environment providing DHCP leases for 4 VLAN's"
dhcp := DHCPServer new.
dhcp addRange: 'VLAN-DC1' cidr: '192.168.1.0/24';
     addRange: 'VLAN-DC2' cidr: '192.168.2.0/24';
     addRange: 'VLAN-DC3' cidr: '172.30.0.0/18';
	  addRange: 'Core-Services' cidr: '192.168.10.0/24';
	  addRange: 'VPN' cidr: '10.0.0.0/8'.

10 atRandom timesRepeat: [
		demo addWorkload: (Workload new name: hostname generateName;
		role: 'A';
		application: 'B';
	   environment: 'C';
		location: 'D';
		addIPAddress: (dhcp getLease: 'VLAN-DC1')).
	].
10 atRandom timesRepeat: [
		demo addWorkload: (Workload new name: hostname generateName;
		role: 'A';
		application: 'B';
	   environment: 'C';
		location: 'D';
		addIPAddress: (dhcp getLease: 'VLAN-DC2')).
	].
10 atRandom timesRepeat: [
		demo addWorkload: (Workload new name: hostname generateName;
		role: 'A';
		application: 'B';
	   environment: 'C';
		location: 'D';
		addIPAddress: (dhcp getLease: 'VLAN-DC3')).
	].
30 atRandom timesRepeat: [ dhcp getLease: 'VPN' ].

				
workloader := WorkloaderWrapper new.
"Create flow records based on the issued DHCP leases, randomized over src address and services provided"
workloader importWorkloads: demo workloads.

demo createFlows: dhcp addresses.
"Use workloader to import the flows into a PCE"
workloader importFlows: demo flows
]

{ #category : #script }
DemoScript >> script3 [

	<script: 'self new script3'>
	| demo application workloader hostname dhcp |
	demo := IllumioDemo new.

	hostname := HostnameGenerator new.

	dhcp := DHCPServer new addRange: 'VLAN23' cidr: '172.30.0.0/18'.

	1 to: 20 do: [ :i | 
		| appName |
		appName := 'APP-' , i asString.
		application := Application new
			               name: appName;
			               environment: demoHelper randomEnvironment;
			               location: demoHelper randomLocation.
		10 atRandom timesRepeat: [ 
			demo
				addWorkload: (Workload new
						 name: hostname generateName;
						 role: demoHelper randomRole;
						 operatingSystemDetail: demoHelper randomOSDetail;
						 operatingSystem: demoHelper randomOS;
						 addIPAddress: (dhcp getLease: dhcp randomSubnet))
				toApplication: application ] ].

	demo createFlows: dhcp addresses.

	workloader := WorkloaderWrapper new.
	workloader importWorkloads: demo workloads.
	workloader importFlows: demo flows
]

{ #category : #script }
DemoScript >> script4 [

	<script: 'self new script4'>
	| demo workloader dhcp |
	demo := IllumioDemo new.
	dhcp := DHCPServer new addRange: 'VLAN23' cidr: '172.30.0.0/18'.

	1 to: 50 do: [ :i | 
		demo addWorkload: (Workload new
				 name: 'W' , i asString , { 'MKH'. 'MLB'. 'FFD' } atRandom
					 , { 'IIS'. 'CSV'. 'ADC' } atRandom , 999 atRandom asString;
				 addIPAddress: (dhcp getLease: dhcp randomSubnet)) ].

	workloader := WorkloaderWrapper new.
	workloader importWorkloads: demo workloads
]

{ #category : #script }
DemoScript >> script5 [

	<script: 'self new script5'>
	| demo application workloader hostname dhcp |
	demo := IllumioDemo new.

	hostname := HostnameGenerator new.

	dhcp := DHCPServer new addRange: 'VLAN23' cidr: '172.30.0.0/18'.

	1 to: 20 do: [ :i | 
		| appName |
		appName := 'APP-' , i asString.
		application := Application new
			               name: appName;
			               environment: demoHelper randomEnvironment;
			               location: 'Haarlem'.

		10 atRandom timesRepeat: [ 
			demo
				addWorkload: (Workload new
						 name: hostname generateName;
						 addIPAddress: (dhcp getLease: dhcp randomSubnet))
				toApplication: application ] ].

	demo createFlows: dhcp addresses.

	workloader := WorkloaderWrapper new.
	workloader importWorkloads: demo workloads.
	workloader importFlows: demo flows
]

{ #category : #script }
DemoScript >> script6 [
<script: 'self new script6'>
| demo workloader dhcp |

"Create a new demo environment"
demo := IllumioDemo new.
"Create a DHCP server for this demo environment providing DHCP leases for 4 VLAN's"
dhcp := DHCPServer new.
dhcp addRange: 'VLAN-DC1' cidr: '192.168.1.0/24';
     addRange: 'VLAN-DC2' cidr: '192.168.2.0/24';
     addRange: 'VLAN-DC3' cidr: '172.30.0.0/18';
	  addRange: 'Core-Services' cidr: '192.168.10.0/24';
	  addRange: 'VPN' cidr: '10.0.0.0/8'.

10 timesRepeat: [
		dhcp getLease: 'VLAN-DC1'.
		dhcp getLease: 'VLAN-DC2'.
		dhcp getLease: 'VLAN-DC3'.
		dhcp getLease: 'Core-Services'
	].
30 atRandom timesRepeat: [ dhcp getLease: 'VPN' ].
				
demo createFlows: dhcp addresses.
"Use the workloader wrapper to export the flows as CSV"
workloader := WorkloaderWrapper new.
workloader exportFlowsAsCsv: demo flows.
]

{ #category : #script }
DemoScript >> script8 [

	<script: 'self new script8'>
	| workloader demo dhcp workload hostname |
	"Create a new demo environment"
	demo := IllumioDemo new.

	"Create a DHCP server for this demo environment and create a subnet from which to hand-out leases"
	dhcp := DHCPServer new.
	dhcp addRange: 'VLAN1' cidr: '10.0.0.0/8'.
	hostname := HostnameGenerator new.
	10 timesRepeat: [ 
		workload := Workload new
			            name: hostname generateName;
			            role:
				            'app' , 10000 atRandom asString , '-env'
				            , 10000 atRandom asString , '-l'
				            , 10000 atRandom asString , '-s'
				            , 10000 atRandom asString , '-e'
				            , 10000 atRandom asString
				            , #( '-PROD' '-SYST' '-TEST' ) atRandom , '-V'
				            , 10000 atRandom asString;
			            location: 'DC1';
			            addIPAddress: (dhcp getLease: dhcp randomSubnet).
		demo addWorkload: workload ].
	workloader := WorkloaderWrapper new.
	workloader importWorkloads: demo workloads
]
