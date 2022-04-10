"
I represent a WorkloaderWrapper. I generate the correct csv output to be able to import iplist, workloads and other PCE objects by issueing the corresponding workloader command to perform the actual import.
"
Class {
	#name : #WorkloaderWrapper,
	#superclass : #Object,
	#instVars : [
		'workloaderPath'
	],
	#classInstVars : [
		'workloaderPath'
	],
	#category : #'illumioWorkbench-Utils'
}

{ #category : #accessing }
WorkloaderWrapper class >> path: aPath [
	^ self new path: aPath.

]

{ #category : #'as yet unclassified' }
WorkloaderWrapper >> cleanup [
	| outputFile |
	
	"Delete any previous out and input files"
	outputFile := 'umwls.csv' asFileReference.
	outputFile exists ifTrue: [ outputFile delete ].
	
	"Get all the unmanaged workloads in a CSV file"
	self executeCommand: 'wkld-export --unmanaged-only --output-file ', outputFile fullName.
	"Delete the unmanaged workloads using the workloader delete command and mapping to the href field of the previously exported workload data, but only if there are workloads"
	outputFile exists ifTrue: [ 
		self executeCommand: 'delete --header href ', outputFile fullName, ' --update-pce --no-prompt'
	].

	"Delete any previous out and input files"
	outputFile := 'iplists.csv' asFileReference.
	outputFile exists ifTrue: [ outputFile delete ].
	
	"Get all the iplists in a CSV file"
	self executeCommand: 'ipl-export --output-file ', outputFile fullName.
	"Delete the iplists using the workloader delete command and mapping to the href field of the previously exported iplist data, but only if there are iplists"
	outputFile exists ifTrue: [ 
		self executeCommand: 'delete --header href ', outputFile fullName, ' --provision --update-pce --no-prompt'
	].
	
	"Delete the unused labels"
	self executeCommand: 'labels-delete-unused'.
]

{ #category : #'as yet unclassified' }
WorkloaderWrapper >> configuredPCEs [
	^ self executeCommand: 'pce-list'
]

{ #category : #'as yet unclassified' }
WorkloaderWrapper >> defaultPCE [
	^ self executeCommand: 'get-default'
]

{ #category : #'as yet unclassified' }
WorkloaderWrapper >> defaultPCE: aPCE [
	self executeCommand: 'set-default ' , aPCE
]

{ #category : #'as yet unclassified' }
WorkloaderWrapper >> executeCommand: aCommandString [
	Transcript show: 'Using workloader to execute: "', aCommandString, '"';cr.

	"OSSUnixSubprocess new
		command: workloaderPath, '/workloader';
		workingDirectory: self workloaderPath;
		arguments: aCommandString;
		redirectStdout;
		runAndWaitOnExitDo: [ :process :outString  |
		Transcript show: outString]"
^ LibC resultOfCommand: ('cd ', workloaderPath, ';./workloader ', aCommandString)
]

{ #category : #'as yet unclassified' }
WorkloaderWrapper >> exportFlowsAsCsv: aFlowCollection [ 
	| outputFile |
	 
	outputFile := 'flows.csv' asFileReference.
	"Get rid of a previous output file, in case it exists"
	outputFile exists ifTrue: [ 
		outputFile delete 
	].

	outputFile writeStreamDo: [ :file | 
  		(NeoCSVWriter on: file) 
	 	nextPut: #(src dst port proto);
    	addFields: #(src dst port proto);
    	nextPutAll: aFlowCollection].
	^ outputFile 
]

{ #category : #'as yet unclassified' }
WorkloaderWrapper >> importFlows: aFlowCollection [ 
	| outputFile |
	 
	outputFile := 'flows.csv' asFileReference.
	"Get rid of a previous output file, in case it exists"
	outputFile exists ifTrue: [ 
		outputFile delete 
	].

	outputFile writeStreamDo: [ :file | 
  		(NeoCSVWriter on: file) 
	 	nextPut: #(src dst port proto);
    	addFields: #(src dst port proto);
    	nextPutAll: aFlowCollection].
	^ self executeCommand: 'flow-import ', outputFile fullName
]

{ #category : #'as yet unclassified' }
WorkloaderWrapper >> importIPLists: anIPListCollection [
	| outputFile |
	 
	outputFile := 'iplists.csv' asFileReference.
	"Get rid of a previous output file, in case it exists"
	outputFile exists ifTrue: [ 
		outputFile delete 
	].

	outputFile writeStreamDo: [ :file | 
  		(NeoCSVWriter on: file) 
	 	nextPut: #(name description include exclude fqdns external_data_set external_data_ref href);
    	addFields: #(name description include exclude fqdns external_data_set external_data_ref href);
    	nextPutAll: anIPListCollection ].
	^ self executeCommand: 'ipl-import ', outputFile fullName, ' --provision --no-prompt --update-pce'
]

{ #category : #'as yet unclassified' }
WorkloaderWrapper >> importWorkloads: aWorkloadCollection [
	| outputFile |
	 
	outputFile := 'workloads.csv' asFileReference.
	outputFile exists ifTrue: [ outputFile delete ].
	outputFile writeStreamDo: [ :file | 
  		(NeoCSVWriter on: file) 
	 	nextPut: #(hostname name role application environment location interfaces os_detail os_id);
    	addFields: #(hostname name role application environment location interfacesAsString operatingSystemDetail operatingSystem);
    	nextPutAll: aWorkloadCollection].
	
	^ self executeCommand: 'wkld-import --umwl ', outputFile fullName, ' --no-prompt --update-pce --debug'
]

{ #category : #initialization }
WorkloaderWrapper >> initialize [

	self path: '/Users/mdejong/Projects/workloader'
]

{ #category : #accessing }
WorkloaderWrapper >> path: aPath [
	workloaderPath := aPath
]

{ #category : #accessing }
WorkloaderWrapper >> workloaderPath [
	^ workloaderPath
]
