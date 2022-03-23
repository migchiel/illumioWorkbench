Class {
	#name : #BaselineOfillumioWorkbench,
	#superclass : #BaselineOf,
	#category : #BaselineOfillumioWorkbench
}

{ #category : #baselines }
BaselineOfillumioWorkbench >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: 'illumioWorkbench';
			package: 'illumioWorkbench-Tests'
			with: [ spec requires: #( 'illumioWorkbench' ) ];
	
			baseline: 'PetitParser'
			with: [ 
				spec repository: 'github://moosetechnology/PetitParser:v3.x.x/src' ];
			baseline: 'PetitParser2Core'
			with: [ spec repository: 'github://kursjan/petitparser2' ];
			package: 'illumioDSL'
			with: [ spec requires: #( 'PetitParser2Core' ) ];
			package: 'illumioAPI';
			baseline: 'ZincHTTPComponents'
			with: [ spec repository: 'github://svenvc/zinc/repository' ];
			baseline: 'NeoCSV'
			with: [ spec repository: 'github://svenvc/NeoCSV/repository' ];
			baseline: 'Roassal3'
			with: [ spec repository: 'github://ObjectProfile/Roassal3' ] ]
]
