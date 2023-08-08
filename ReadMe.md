# Acoustics Array
This is the readme file for the 2023 IRES acoustics work. It will include documentation about the folders 
and what is in each folder. 

Sam Kramer

Acoustics Engineering Team lead

Summer 2023

> [!NOTE]
> This is not the only documentation on the acoustics setup.

## Use of System

> [!NOTE]
> There is a separate documentation file that is a .mlx for use and goes into depth on coding aspects.

### 1. Turning on and running the system
To turn on and run the acoustics array, first turn on the power supply that is located next
to the DAQ. Also turn on the DAQ. To get to the Control App, go to matlab and look in the Apps section
and it should be under favorites. If not there is an installer located within this repository under
the name `Array Control Pannel`. The source code is also located within the repository control pannel
folder. You may make any coding changes to it through this source code. You then must reinstall the app.

### 2. Running a test
Once the app has been opened, simply wait for it to initialize fully. It will have all the fields greyed-out
until this has been completed. Once this has fully initialized, you may then start to configure the tests using the fields within the control tab.

There are three separate tabs, control, acoustics, and camera config. There is very limited use in the camera config tab, however you are able to visualize the camera trigger output signal. The acoustics tab has 
some acoustics configuration but mostly is there for saving the data. You are able to title the file name and then click save data. This will automatically make a new directory based on the date under "Testing {Date}" in the "Test Data" folder. While the data is saving, the "Save Data" button will be greyed out.

To visualize any data you have taken, the app can automatically show you the last test you took by pressing the "Visualize Data" button. This will show the last dataset you took from all mics. From within the MATLAB 
IDE we can use some of the following features

1. visualize_data() -- Visualize entire unfiltered dataset
1. analyze_data() -- Will show dataset, and a windowed filtered dataset of one mic, and a spectrogram
1. find_chirps() -- Will find chirps from an entire dataset and save the spectrograms
1. spectrogram_data() -- will create a spectrogram for a window for one mic
1. specfilt_data() -- will make a filtered spectrogram of the data for one mic for a specific time window

## Files:
### 1. Test Log -		
This is the test log that is for official tests where data acquisition of bat flight is	
the main goal. Tests to validate system will also be logged and should be done regularly
to prevent degradation of system capabilities. Any mics not working or problematic will be
noted within the test log notes. Note every test, including validation tests.

### 2. Operation Manual -	
This is the MATLAB live script that is the operation manual for the entire acoustics array
and is executeable within the IDE. If the DAQ is connected and setup properly the live script
will run the code and collect data. This is meant as an example for the data collection system
that is programmed into the app. The user is able to read through what the app is doing and then
also able to see what each line does. The operation manual also lists a cheat-sheet for the analog
inputs of the microphones for troubleshooting. The operations for the microphones and a debugging 
guide is also available within this document. It is highly encouraged to read through this document
before any major engineering is done to system. A majority of technical documentation is located here.

### 3. Folder Guide -	
This is a PNG file that shows the tree folder order within the Acoustics Array folder. This should 
be taken as a user guide for the location of the different folders if they are searching for a
specific data set or folder. If there is some sort of restructuring, this should be updated. This is NOT 
included in the github and is noted on the .gitignore, only located on drive and locally on lab.

### 4. .gitignore -		
The gitignore file is a tool for the acoustics github. This file includes all the files on the lab
computer's HDD that are not needed on the github. This includes files like the data, documentation, and 
media. These are not needed on github becuase the drive is better suited for the saving and sharing of these
files.

## Folders:
### 1. Test Data -		
This is the folder that holds all the test data that was collected by the acoustics array.
This holds all raw data files in the form of .mat files. The naming convention for the test files is [TYPE][DATE-GROUP] i.e. Testing 22JUN2023. The control
app mentioned below will automatically handle the files and naming conventions based on the date. There is also a directory
handler function within the app that will automatically point to this folder and handle the directory properly. **DO NOT DELETE THIS FOLDER**.

### 2. Control Pannel - 
This is the folder that will store the array control pannel. There are other 
files that are located here to assist with the app itself. There are audio files with .mp3 
and .wav for outputting sound from the app. The app has an instructions markdown file that you
may read on the first page under the instructions button. Within the folder there is also an installer
in case you may want to install the app on another machine. This package was coded in the app designer
and is located in the app section of the MAT IDE. You may also run the app from the top toolbar. This
is the preffered method of running the array because it handles data much better and faster than the mic
control pannel. Within this app there are multiple tabs for different control aspects of the array. The
most important parts are the control page which is used to configure the tests. To change the length of
the test time, you may change the duration box, same goes for the frequency box. There are set presets
that will work with the cameras during tests. To run just acoustics array tests, simply switch off the
camera toggle in the top right corner. To visualize the acoustic data you have collected you may click
the visualize data button in the acoustics control page.
	
### 3. Libraries - 	
>[!NOTE]
>There is individual, in-depth documentation for each function within the function file. Type `>>help func_name` in command window to see documentation.

This is the functions library that will be used to store all the functions that are going to
to be used for the data acquisition. These functions will mainly be used in the combined 
camera and acoustics app. They also appear within the acoustics control pannel app. Please read
the independent documentation on each one that is provided in the function file. 

**add_daq_channels:** 	

This is a function that will be used to simply add the NI Daq in the lab and then create 32 analog input ports to collect data, 
the only output is the daq object.

**save_daq_data:** 

This is a function that will create a new .csv file with the data collected from from the tests. This will need the user to imput 
the data, the time stamps for the tests and also the desired name without the .csv at the end. There are no outputs.

**background_noise_test:** 

This is a function that will take a 5 second background test for a control of the standard acoustic tests. This will output a saved 
.csv file with data taken at a sample rate of 250 kHz.
		
**visualize_data:**

This is a function that is a helper function for the app and is meant to help the user identify which mics are not working before a 
test begins. This can be called within command line and can can also be called within app. This is linked to "Mic Check" button in 
the app. The outputs for are simply the graphs of the SPL for the microphones within the system.

**filter_data:** 

This function simply filters out the data for the user to remove any noise in the system. This uses a 9th order bandpass filter with 
the user defined frequency band.

**visualize_filtered_data:**

This is a function that will filter the data based on a user input center frequency with a 15% frequency band. This uses a 4th order 
butterworth bandpass to filter the data. This relies on the visualize_data and filter_data functions which are also within the libraries 
folder. 
		
**trigger_cameras:**

This is a function that will be used to trigger the camera system as well as collect mic data simultaneously from the array. This is mainly
a template for the commands used in the app.

**crosscorrelation:**

This is a function that takes a cross correlation of two separate datasets for analyzing data for any echoes or any chirps. This can help 
the team identify where there are chirps in the datasets.

**create_chirp:**

This is a function that can be used to create a vector of data points that have a swept frequency cosine, otherwise known as a chirp. This
takes in a variety of user defined parameters. This is for data analysis and using the cross correlation function to identify chirps in the data. 
We can directly view the outputs from the data in spectrogram form using the `visualize::AbsString = "true"`parameter when passed to the function. Ignore this to turn 
off the output response graph. 

**spectrogram_function:**

This is a function that can be used to create a spectrogram of a single data vector in the linear scale.

**spectrogram_function_dB:**

This is a function that creates a spectrogram of a single data vector using the dB scale. There is use for this function if you wish to see acoustic
data within the dB scale. Some datasets with low noise appear cleaner when in the dB scale, other times it appears worse. This is mainly a tool 
for simple use. 

**spectrogram_data:**	

This function will take in the entire dataset and then take a spectrogram of the data you pass to it. It can be toggled to use the linear or dB 
scale using the `type::AbsString = "Linear"` or `type::AbsString = "Log"` settings when calling the function.

**specfilt_data:**

This function takes in data and filters it and then takes the spectrogram. This has set filter parameters that match what the batbot outputs 
from the system.

**analyze_data:** 

This function can help make the first basic steps to analyzing the collected data. This is meant to remove alot of the coding aspects in creating 
analysis scripts, we can pass a time value set and it will show that time period within the spectrograms and plots. Will produce a 3 figure subplot
that has the entire dataset and a windowed dataset, and then a filtered, windowed dataset. It will also show a spectrogram of that time window. 
		

### 4. Media -		
This folder contains any media that is used in the operation manual or from any tests. This should only be
media files. I.e. .mp3 files, .jpeg images, etc. Raw data should be placed within the data folder. 


### 5. Documentation - 	
This folder contains all the documentation that is useful for the acoustics array. Including, the DAQ
documentation, the terminal documentation, the microphone documentation, etc.


### 6. Depreciated - 	
All old code from previous years that has been superceded by newer code.


### 7. Array Procedures - 	
This folder contains any instructions on procedures for testing. This is different than the documentation
or operation guide. This mainly pertains to safety of the system. 
			
