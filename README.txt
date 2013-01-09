Using the questionnaires app:

Latest changes: On the initial screen, you can now select an upload and download directory.  If you select an upload directory that doesn't exist, and then you upload, you will see a 'dropbox error 404', but then the directory will be created and uploaded to.

If you type in a download directory that doesn't exist, and then try to download, you will also get the 'dropbox error 404', but then there won't be an option to do anything but quit or retry until you enter a valid download directory.

Be aware that the download and upload directories are used when you download and upload.  If you want several people to upload into their own folders, upload personOne files to personOneDirectory before having personTwo answer questions. 

Dropbox automatically retries any uploads or downloads that time out.  

The first screen you see has buttons for linking, unlinking, uploading to dropbox, downloading from dropbox, and clearing previously downloaded questions.  There are options to change download and upload directories. You can also continue to the question selector or quit.

This version is linked to the algebraresearch@gmail.com dropbox account.  So far, the folders used are 'uploadNumberStims' and'downloadNumberStims'  

Download and upload are from the perspective of the iPad.  

It would probably be best for the person administering the experiment to use the first screen, and the question selector, then hand the iPad to the person answering the questionnaires.

A question list must have the extension '.txt' to work, and it must be UTF8 encoded.  It is possible to use a list of question files, this must have a .ord extension.  Again, it must be UTF8.

The app will only rotate to portrait and portrait upside down, so that the formatting for multiple choice works.

Entries are separated by a <tab>. Spaces will not work.

The first line of the input file is a header line, use it to keep track of what is in which place. Also, include the file name that it is a header line for, and any info you think will be handy later.  The header line must start with the word 'head'

On the next lines, the first entry is the question number.  The question numbers do not have to be in order, and do not even have to be numbers.  If they are sequential numbers though, it should make everything easier to keep track of.  If jumping to a line number, the app thinks of the header line is line number 0, the first question is line number 1, etc.

The second entry is a comment.  It can be whatever you want, just so long as there are no <tab>s in it. 

The third entry is block.  If block is 0, questions are presented to the user in the order that they appear in the input file.  A block is made up of all the lines that appear one after the other with the same block number.  A block is presented to the user in the order of the lines in the input file.  Blocks are randomized.  After a chunk of random blocks, there must be a line with block = 0.  The output file shows questions in the order that the user answered them.

The fourth entry is the type of question.  The question type is case sensitive.  Currently the valid question types are: numberline, wordFill, numberFill, instruction, picture, multipleChoice, speech, feedback, audioNumberline, titration, titrationBranch, branchTo, and branchOut.

The fifth entry is the time limit, in seconds.  A picture could be displayed for 600 milliseconds by making this entry 0.600 A time limit of -1 (or any number not greater than 0) means there is no time limit. branchTo and titrationBranch do not use a time limit, so the fifth entry is ignored.

At any point in a question or instruction, a new line can be started with the text &NL

The output file is formatted much like the input file. The extension is '.ans' 
The first line is the file name, which contains the name of the iPad, and the date and time the app was launched.  The output file has too more entries in it, the first is the answer from the user, the second is the time it was submitted.  

If the time runs out, the answer is "Time ran out." followed by anything the user entered without pushing the submit button.

The time format is Hour_minute_seccond.miliseconds.  The clock is 24 hour.

There are probably bugs.  Let me know if/when you find them.


-Thad

******************
In a numberline question, entries are as follows   
	6: text of question.
        7: the text/number at the left end of the numberline.
	8: the text/number at the right end of the numberline.  

The answer is a floating point number, 0 to 100.

Example:
6	numberlineExample	0	numberline	15	Please place the indicated value at the proper location on the numberline: 1,000,100	0	1 billion

This line is not randomized, 15 second timeout, and has the user place 100100 between 0 and 1 billion.

******************
In a wordFill question, 
       6: text of question.
Example:
11	wordfillExample	0	wordFill	-1	Please enter some words.

Again, not randomized, this time with no timeout.  It asks the user to enter some words.

******************
In a numberFill question, 
       6: text of question.
       
The only difference between this and a wordFill question is that the default keyboard is the one with numbers.

Example:
11	numberFillExample	0	numberFill	-1	Please enter some numbers.

Again, not randomized, this time with no timeout.  It asks the user to enter some numbers.

******************
In an instruction, 
       6: text to display. 
       7: weather or not there is a continue button (yes or no).  
       8: is it a large and centered word (yes or no).
       
If there is no continue button, it is important that there be a reasonable time limit.

Example:
4	instructionExample	0	instruction	-1	Make sure to keep the image in memory as you write the number!! &NL&NLDuring the pause after the first image, actively rehearse the image in your mind.	yes	no					
In this example, the instruction has no timeout, and is not randomized.  The text has a couple new lines in it.  There is a continue button, and the text is not large and centered.

******************
In a picture, 
       6: the filename of the picture.  
       7: weather or not there is a continue button (yes or no).  

Pictures are centered if they are smaller than the picture view, and resized to fit if they are larger.

Example:
28	pictureExample	0	picture	1.5	mask.png	no						
In this example, the picture is a file called mask.png, there is no continue button, and the picture is displayed for 1.5 seconds.

******************
In a multipleChoice question, 
       6: text of question.
       7: the first answer choice.
       
There can be up to 12 choices.

Example:
22	multipleChoiceExample	0	multipleChoice	-1	Are the first and second image identical?	yes	no					
In this example, the user is asked if two images were identical.  'yes' and 'no' are the choices.

******************
In a speech question, 
       6: text to be displayed.
       7: time in seconds to pause before speech begins.
       8: text to convert to speech.
       9: time to pause between repeats.
       10: number of times to repeat.
       11: continue button visible (yes or no).
       12 label visible (yes or no).
       13 text input visible (yes or no).
       
The pause between saying something and repeating starts when the speech begins, not when it ends.
I used a speech synthesizer written at Carnegie Mellon.  The license is at the end of this document.

When speech is synthesized, the speech synthesizer shows the user a blank screen, while a wave file is generated.  

Speech returns two lines in the output file.  The first one gives the time after the synthesizer has generated the wave file, so if it takes a few seconds to do that, you know it is not time the user waited before pressing  continue.

The label is text instructions, from entry 6.

Example:
30	speechExample	0	speech	5	Time's up!	0	Time is up... Press continue.	5	1	yes	yes	no

Here, there is a 5 second timeout.  The text 'Time's up!' is displayed. There is no pause before speech begins, the speech synthesizer says 'Time is up... Press continue.'  This is said 1 time, so pause after and repeat are irrelevant.  The continue button and text label are visible, but there is no text entry box.

******************
In a branchOut question, 
        6: text of question.
        7: the first answer choice.
	8: the name of the input file to switch to if this choice is chosen.
	9: the line number in that input file to start with.
	
This is similar to a multiple choice question, but the answer picked by the user can cause the input file and line number to change. There can be up to 12 choices, for a total of 42 entries.  If time runs out, the current input file and next line number are used.

Any time the input file changes, the header line for the new input file marks where questions from the new input file start.

Example:
3	branchOutExample	0	branchOut	45	Do you have time for a survey with more than 15 questions?	yes	sampleQuestionList.txt	4	no	noTime.txt	0	got time for a few	sampleQuestionList.txt	12

Here, if the user has time, execution continues with the next question.  If the user has no time, it switches to a different input file, and if the user has a little time, it skips forward in the question list.

******************
In a branchTo line,
	6: the name of the input file to switch to.
	7: the line number in that input file to start with.

A branchTo line is like a branchOut line, but it is not conditional. 

Example:
8	branchToExample	0	branchTo	-1	sampleQuestionList.txt	10
9	branchToExample	0	instruction	-1	This question gets skipped.  Perhaps this could be used for debugging or commenting.	yes	no

******************
In an audioNumberLine question, 
	6: text of question.
        7: the text/number at the left end of the numberline.
	8: the text/number at the right end of the numberline.  
       9: time in seconds to pause before speech begins.
       10: text to convert to speech.
       11: time to pause between repeats.
       12: number of times to repeat.

Example:
11	audionumberlineEexample	0	audioNumberLine	14	Please place the number that you hear on the number line.	0	1 billion	0	zero	3	2
Here, the text 'Please place the number that you hear on the number line.' is displayed, and there is a numberline from 0 to 1 billion.  No pause before 'zero' is pronounced, 3 second pause, 'zero' gets said 2 times.


******************
In a feedback line,
	6: previous answer a user submitted.
	7: text to display if that is the previous answer.

This is repeated for the number of answer choices in the previous question.
A feedback line can only follow a multipleChoice or titration question. If you asked a user to choose between A,B,and C possible answer choices would be A,B,C,Time ran out.,Time ran out. A, Time ran out. B, Time ran out. C.  

The easiest way to deal with this confusion would be to not set a time limit on questions you plan to give feedback for.

Example:
16	feedbackExample	0	feedback	-1	yes	Good job! The sequences were identical.	no	Actually, the two sequences were identical.			

Here, is the previous answer was 'yes' it tells the user 'good job' and if the previous answer was 'no' it tells the user that the answer should have been yes.


******************
In a titration question,
	6: The correct answer.
	7: (spatial or verbal).
        8: text of question.
        9: the first answer choice.

        There can again be up to 12 answer choices.

Any time three questions have been answered at a level, and at least two of them were correct, the titration level (verbal or spatial) is increased.

Example:
49	titrationExample	0	titration	-1	yes	verbal	Are the first and second sequences of words identical?	yes	no

Here, the sequences of words were identical.  It was a verbal question.  

******************
In a titrationBranch line,
	6: (spatial or verbal).
	7: if the current level is this number.
	8: the name of the input file to switch to if at level.
	9: the line number to start with in that input file.

         This can continue up through 5 levels.  A titrationBranch can be used a couple different ways:  If the user has answered 2 out of 3 questions correctly, the level increases.  At that point, a titrationBranch can be used to change to harder questions for the next level.  Another use is after the users level has been determined, a titrationBranch can be used to change to a list of questions for a person at that level.

Example:
50	titrationBranchExample	0	titrationBranch	-1	verbal	4	titration_verbalint_level4.txt	0	

Here, if the verbal titration level is 4, the user is switched to input file 'titration_verbalint_level4.txt'



******************



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
