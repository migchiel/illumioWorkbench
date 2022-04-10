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
			baseline: 'NeoCSV'
			with: [ spec repository: 'github://svenvc/NeoCSV/repository' ]]
]
