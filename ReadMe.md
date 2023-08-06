# Acoustics Array ReadMe.md
This is the readme.md file for the 2023 IRES acoustics work. It will include documentation about the folders 
and what is in each folder. 

Sam Kramer
Acoustics Engineering Team lead
Summer 2023

## Files:
1. Test Log -		This is the test log that is for official tests where data acquisition of bat flight is	
			the main goal. Tests to validate system will also be logged and should be done regularly
			to prevent degradation of system capabilities. Any mics not working or problematic will be
			noted within the test log notes. Note every test, including validation tests.

2. Operation Manual -	This is the MATLAB live script that is the operation manual for the entire acoustics array
			and is executeable within the IDE. If the DAQ is connected and setup properly the live script
			will run the code and collect data. This is meant as an example for the data collection system
			that is programmed into the app. The user is able to read through what the app is doing and then
			also able to see what each line does. The operation manual also lists a cheat-sheet for the analog
			inputs of the microphones for troubleshooting. The operations for the microphones and a debugging 
			guide is also available within this document. It is highly encouraged to read through this document
			before any major engineering is done to system. A majority of technical documentation is located
			here.

3. Folder Guide -	This is a PNG file that shows the tree folder order within the Acoustics Array folder. This should 
			be taken as a user guide for the location of the different folders if they are searching for a
			specific data set or folder. If there is some sort of restructuring, this should be updated. This is NOT 
			included in the github and is noted on the .gitignore, only located on drive and locally on lab.

4. .gitignore -		The gitignore file is a tool for the acoustics github. This file includes all the files on the lab
			computer's HDD that are not needed on the github. This includes files like the data, documentation, and 
			media. These are not needed on github becuase the drive is better suited for the saving and sharing of these
			files.

## Folders:
1. Test Data -		This is the folder that holds all the test data that was collected by the acoustics array.
			This holds all raw data files in the form of .mat files. There are two sub-folders one
			designated for validation data for system, and another for data acquisition from full-speed
			bat tests. The naming convention for the test files is [TYPE][DATE-GROUP] i.e. Validation 22JUN23.

2. Control Pannel - 	This is the folder that will store the standalone acoustics control pannel. There are other 
			files that are located here to assist with the app itself. There are audio files with .mp3 
			and .wav for outputting sound from the app.
		
	### Mic_Control_Pannel (DEPRECIATED):
				This is a MATLAB app that will be used to setup and collect data from just the acoustics
				array. This has three different sections relating to data acquisition and then data 
				saving, and then also sound outputting. Sound output section is more used for debugging
				and ensuring the system works properly. For saving data as a .mat file, do not include .mat
				to the title as it will include it automatically. Also ensure to make the name .mat file 
				naming convention friendly (i.e. no '\, /, etc'). This app is also located within the MATLAB 
				app library as a packaged app. The installer is located in this folder too should it need to
				be reinstalled. There are multiple versions of this app and the most recent one should be on
				the .mlapp file located within this folder. If the app in matlab IDE is not up to date simply
				package the app again and the shortcut will work for newest version of the app. There is a file
				on operation that is useful for understanding the control panel app. This file outputs all the
   				as a timetable object.

	### Array_Control_Pannel:
				This is a MATLAB app that is used to setup and run the entire array from a single computer. This
   				package was coded in the app designer and is located in the app section of the MAT IDE. You may
   				also run the app from the top toolbar. This is the preffered method of running the array because
   				it handles data much better and faster than the mic control pannel. Within this app there are
   				multiple tabs for different control aspects of the array. The most important parts are the control
   				page which is used to configure the tests. To change the length of the test time, you may change
   				the duration box, same goes for the frequency box. There are set presets that will work with the
   				cameras during tests. To run just acoustics array tests, simply switch off the camera toggle in the
   				top right corner. To visualize the acoustic data you have collected you may click the visualize data
   				button in the acoustics control page.
					
	
	3. Libraries - 		This is the functions library that will be used to store all the functions that are going to
			 	to be used for the data acquisition. These functions will mainly be used in the combined 
				camera and acoustics app. They also appear within the acoustics control pannel app. Please read
				the independent documentation on each one that is provided in the function file. 

		Functions Files:

		add_daq_channels: 	This is a function that will be used to simply add the NI Daq in the lab and then 
					create 32 analog input ports to collect data, the only output is the daq object.

		save_daq_data: 		This is a function that will create a new .csv file with the data collected from 
					from the tests. This will need the user to imput the data, the time stamps for the 
					tests and also the desired name without the .csv at the end. There are no outputs.

		background_noise_test: 	This is a function that will take a 5 second background test for a control of the 
					standard acoustic tests. This will output a saved .csv file with data taken at a 
					sample rate of 250 kHz.

		spectrogram_data:	This is a function that will take the spectrogram of the data that is input and the
					microphone number that is input as well. This is mainly a helper method that is for mic_check
					function for checking if a mic isn't working properly. This outputs 1 graph which is the
					spectrogram. Defaults at to be -60 to 0 dB power scale.
		
		visualize_data:		This is a function that is a helper function for the app and is meant to help the user identify
					which mics are not working before a test begins. This can be called within command line and can
					can also be called within app. This is linked to "Mic Check" button in the app. The outputs for 
					are simply the graphs of the SPL for the microphones within the system.

		filter_data: 		This function simply filters out the data for the user to remove any noise in the system. This uses
					a 9th order bandpass filter with the user defined frequency band.

		visualize_filtered_data:This is a function that will filter the data based on a user input center frequency 
					with a 15% frequency band. This uses a 4th order butterworth bandpass to filter the data. This relies
					on the visualize_data and filter_data functions which are also within the libraries folder. 
		
		trigger_cameras:	This is a function that will be used to trigger the camera system as well as collect mic data 
					simultaneously from the array. This is mainly a template for the commands used in the app.

		crosscorrelation:	This is a function that takes a cross correlation of two separate datasets for analyzing data for
					any echoes or any chirps. This can help the team identify where there are chirps in the datasets.

		create_chirp:		This is a function that can be used to create a vector of data points that have a swept frequency
					cosine, otherwise known as a chirp. This takes in a variety of user defined parameters. This is for
					data analysis and using the cross correlation function to identify chirps in the data.

		spectrogram_data	This function will take in the entire dataset and then take a spectrogram of the data you pass to it.

		specfilt_data		This function takes in data and filters it and then takes the spectrogram. This has set filter 
					parameters that match what the batbot outputs from the system.

		specfilt_data2 		this function takes in the data and filters it and provides a spectrogram. This is a user defined
					filter system and the user must tune the filters themselves.

		analyze_data 		This function can help make the first basic steps to analyzing the collected data. This is meant 
					to remove alot of the coding aspects in creating analysis scripts.
		

	4. Media -		This folder contains any media that is used in the operation manual or from any tests. This should only be
				media files. I.e. .mp3 files, .jpeg images, etc. Raw data should be placed within the data folder. 


	5. Documentation - 	This folder contains all the documentation that is useful for the acoustics array. Including, the DAQ
				documentation, the terminal documentation, the microphone documentation, etc.


	6. Depreciated - 	All old code from previous years that has been superceded by newer code.


	7. Array Procedures - 	This folder contains any instructions on procedures for testing. This is different than the documentation
				or operation guide. This mainly pertains to safety of the system. 
			
