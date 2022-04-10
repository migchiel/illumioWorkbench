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
			baseline: 'PetitParser2Core'
			with: [ spec repository: 'github://kursjan/petitparser2' ];
			baseline: 'PetitParser2Languages'
			with: [ spec repository: 'github://kursjan/petitparser2' ];
			package: 'illumioAPI';
			baseline: 'NeoCSV'
			with: [ spec repository: 'github://svenvc/NeoCSV/repository' ];
			baseline: 'OSSubprocess' with: [ 
				spec repository:
						'github://pharo-contributions/OSSubprocess:master/repository' ]]
]
