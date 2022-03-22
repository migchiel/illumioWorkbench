# illumioWorkbench

illumioWorkbench helps with quickly setting up a demo or test environment in illumio Core (https://www.illumio.com/products/core).

Typical use cases could be, but are not limited to:

-	Policy design and validation
-	Customer, Domain or event specific demo environment creation
-	Learning about the illumio REST API
-	Metrics collection and viewing

Under the hood workloader is used for the some of the use cases (https://github.com/brian1917/workloader) 

The illumio PCE has a very complete REST API, the details of which can be found here: https://docs.illumio.com/core/21.1/Content/LandingPages/Categories/develop.htm

illumioWorkbench is implemented in / using Pharo (https://pharo.org/)

You will need to install Pharo first using this zero conf script for linux 
and OSX :  'curl -L https://get.pharo.org/64/ | bash'. or 'wget -O- https://get.pharo.org/64 | bash' depending on curl or wget being installed.

The Pharo installer for all the supported OS's can be found here: https://pharo.org/download

MIT Licensed.

## Installation

You can load illumioWorkbench into Pharo using Metacello. Just open a playground and paste the Metacello code snippet shown below into it. Select and run it. 

```Smalltalk
Metacello new
  repository: 'github://migchiel/illuStrator:main/releases/latest';
  baseline: 'illumioWorkbench';
  load.
```
## Example script

```Smalltalk

	| demo workloader dhcp hostname |
	"Create a new demo environment"
	demo := IllumioDemo new.
	"Create a DHCP server for this demo environment providing DHCP leases for 4 VLAN's"
	dhcp := DHCPServer new.
	dhcp
		addRange: 'VLAN-OT-SENSORS' cidr: '192.168.1.0/24';
		addRange: 'VLAN-IT' cidr: '192.168.2.0/24';
		addRange: 'VLAN-OT-ACTUATORS' cidr: '172.30.0.0/18'.

	"Create 10 sensors and 10 actuators in the respective VLANS"
	10 timesRepeat: [ 
		dhcp getLease: 'VLAN-OT-SENSORS'.
		dhcp getLease: 'VLAN-OT-ACTUATORS' ].

	"Generate 10 controller unmanaged workloads"
	hostname := HostnameGenerator new.
	1000 timesRepeat: [ 
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
	"Use the workloader wrapper to export the flows as CSV"
	workloader importWorkloads: demo workloads.
	workloader importFlows: demo flows

	"Use workloader to import the workloads generated above into the illumio PCE"
	workloader := WorkloaderWrapper new.
	workloader importWorkloads: demo workloads.

	"Based on the leases generated in the workload creation process, create random flows for some known services between the workloads using TCP and UDP"
	demo createFlows: dhcp addresses.
	workloader importFlows: demo flows

```

In Pharo you can open a playground and evaluate the above script to create an IOT themed demo environment.

