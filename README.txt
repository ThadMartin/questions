Using the questionnaires app:

Latest changes: Since times are recorded to the millisecond, I made custom segues between screens with no animations.  Time limits now work everywhere in milliseconds.  ( 0.600 for 600 milliseconds)

It is better about telling you your input file format is invalid, instead of crashing.

A question list can be local, or on dropbox.  If it is in dropbox, it must be in the folder named "download".  Download and upload are from the perspective of the iPad.  

The first screen you see has buttons for linking, unlinking, and uploading to dropbox.  If you are linked with dropbox, and have an internet connection, you can upload.  This uploads all the answered questionnaires, and removes the files from the iPad once dropbox confirms the upload.  If all files upload, the button title changes to 'upload complete'.  If there is an error, the button will not change, and you can push the button again.

iTunes can also be used to retrieve answers.

In the code, in engagementViewController.m, in viewDidAppear, the two lines of code below can be commented to give a choice about linking to dropbox, or uncommented to connect automatically to dropbox if the app is linked.   The line with Segue in it can be uncommented by its self to skip the first screen entirely.

 //comment the lines below to show the screen to unlink from a dropbox account.
    
   //  if ([[DBSession sharedSession] isLinked])
   //      [self performSegueWithIdentifier: @"toQuestionSelector" sender: self]; 

In the code, in engagementAppDelegate.m, in didFinishLaunchingWithOptions, there are lines that begin with"initWithAppKey" and "appSecret".
These lines can be modified with an app key and an app secret that you can get from 
https://www.dropbox.com/developers
if you want to link the program with a dropbox account that is not the 'algebraresearch@gmail.com' account.  
Go to "MyApps" and add an app for questionnaires.  It will give you the keys.
Once you have the keys, put them in engagementAppDelegate.m
You may also need to create folders named "upload" and "download" in the app's folder.

Also, select engagement-Info.plist, choose 'open as source code', and modify the string after db- to your app key.
<array>
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>db-someNumber</string>
			</array>
		</dict>
	</array>



If you continue from the first screen, there will be a list of questionnaires.  If the app is linked to dropbox, and if there are questionnaires on dropbox that are not on the iPad, they will appear after a few seconds.

Take a look at "sampleQuestionList.txt" for an idea how the question list should look.  A question list must have the extension '.txt' to work.

The app will only rotate to portrait and portrait upside down, so that the formatting for multiple choice works.

The executable is called engagement because when it started it was an app to replace a questionnaire about engagement in math.The text input file must be UTF-8 plain text.  NL, CR, and NL CR newlines should work.

The input file extension must be .txt and UTF-8 encoding.

Entries are separated by a <tab>.  Some text editors enter several spaces when you push the tab key, this will not work correctly.

If a line does not have any <tab>s in it, it will be copied from the input file to the output file.  

I recommend using TextEdit if you are on a mac.  Go to TextEdit -> Properties, and under the New Document tab, select Plain Text, and un-check smart quotes and smart dashes.  In the Open and Save tab, under plain text encoding, change the save file format to Unicode (UTF-8).  

The first line of the input file is a header line, use it to keep track of what is in which place.

On the next lines, the first entry is the question number.  The second entry is the condition. The third entry is the type of question.  The question type is case sensitive.  Currently the valid question types are: numberline, wordFill, numberFill, instruction, picture, multipleChoice, speech, and branchOut.

The fourth entry is the time limit.  A picture could be displayed for 600 milliseconds by making this entry 0.600 A time limit of -1 (or any number not greater than 0) means there is no time limit.  

If the time runs out, the answer is "Time ran out. " followed by anything the user entered without pushing the submit button.

In a numberline question, the fifth entry is the question, the sixth entry is the text at the left end of the numberline, and the seventh entry is the text at the right end of the numberline.  The answer is a floating point number, 0 to 100.

At any point in a question or instruction, a new line can be started with the text &NL

In a wordFill question, the fifth entry is the question.

In a numberFill question, the fifth entry is the question.  The difference between this and a wordFill question is that the default keyboard is the one with numbers.

In an instruction, the fifth entry is the instruction.

In a picture, the fifth entry is the filename of the picture.  The picture area is about 768 by 990 pixels, so if the ratio is about like that, the picture will take up most of the screen.  

In a multipleChoice question, the fifth entry is the question.  This can be followed by up to 12 entries, which are choices.

In a speech question, the fifth entry is text to be displayed, the sixth entry is the time in seconds to pause before speech begins, the seventh entry is the text to convert to speech, the eighth entry is the time to pause between repeats, and the ninth entry is the number of times to repeat.  The pause between saying something and repeating starts when the speech begins, not when it ends.  I will work on that, someday.  

In speech.m, in viewDidLoad, you will see the following lines:

    [fliteEngine setVoice:@"cmu_us_rms"];
//    [fliteEngine setPitch:100.0 variance:50.0 speed:1.0];	// Change the voice properties

You can uncomment the last of those lines, and adjust the pitch, variance, and speed of the voices.

Speech synthesis is courtesy of:
iPhone TTS - This is a port of CMU's Festival-Lite (aka flite) library to the iPhone/iOS platform.
Homepage: http://bitbucket.org/sfoster/iphone-tts/
license:
 Flite is free software. It is distributed under an X11-like license. Apart from the few exceptions noted below (which still have similarly open lincenses) the general license is

                  Language Technologies Institute                      
                    Carnegie Mellon University                        
                     Copyright (c) 1999-2009                          
                       All Rights Reserved.                           
                                                                      
 Permission is hereby granted, free of charge, to use and distribute  
 this software and its documentation without restriction, including   
 without limitation the rights to use, copy, modify, merge, publish,  
 distribute, sublicense, and/or sell copies of this work, and to      
 permit persons to whom this work is furnished to do so, subject to   
 the following conditions:                                            
  1. The code must retain the above copyright notice, this list of    
     conditions and the following disclaimer.                         
  2. Any modifications must be clearly marked as such.                
  3. Original authors' names are not deleted.                         
  4. The authors' names are not used to endorse or promote products   
     derived from this software without specific prior written        
     permission.                                                      
                                                                      
 CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK         
 DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      
 ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   
 SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE      
 FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    
 WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   
 AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          
 ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       
 THIS SOFTWARE.                                                       

In a branchOut question, everything is similar to a multiple choice question, but the answer picked by the user can cause the input file and line number to change.  The sixth entry is the first choice, the seventh entry is the new input file name, and the eighth entry is the new question number.  There can be up to 12 choices, for a total of 41 entries.  If time runs out, the current input file and next line number are used.

The output file is formatted much like the input file. The extension is '.ans' 
The first line is the file name, which contains the name of the iPad, and the date and time the app was launched.  The output file has too more entries in it, the first is the answer from the user, the second is the time it was submitted.  The time format is Hour_minute_seccond.miliseconds.  The clock is 24 hour.

If a branchOut is used to change the input file, the header line for the new input file marks where questions from the new input file start.

As of 7-2012, this code has not been tested much (it worked once or twice) and I'm new at iOS programming.  If you find any bugs, or have any suggestions, you can email me at martin_thad@yahoo.com

