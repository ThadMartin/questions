Lisa,

I just discovered that titration and random by blocks both worked, but they didn’t work at the same time.  I changed it so they work at the same time, and included a new version of the app.

This should make for input files a bit different than the ones you sent me, but I believe you should be able to do everything you want to do with this code.

Don’t hesitate to point out any bugs, ask questions, or make suggestions.

I can think of a couple bugs.  When you upload to dropbox, sometimes the current output file gets uploaded too.  If you get an extra answer file that has only one line, delete it.  Also, once in a while there is a line at the end of the answer file (after all lines with data) that has a couple random characters in it. I may have fixed that one, but I haven’t tested enough to be sure. Another problem is that sometimes dropbox times out on the download.  Didn’t notice it until there were 204 files in the download folder.  If you re-start the app, you get the rest of them, but it should auto-retry.  I’ll keep working on these things.

I have converted part of titration_spatialint_level1_taskorder_S_NLE.txt and put it on dropbox.

Do you have the password to the dropbox account?

Using the questionnaires app:

The first screen you see has buttons for linking, unlinking, and uploading to dropbox. This version is linked to the ‘algebraresearch@gmail.com’ dropbox account, and uses folders ‘/Apps/questionnaires2/uploadNumberStims’ and ‘/Apps/questionnaires2/downloadNumberStims’  
Download and upload are from the perspective of the iPad.  

Once input files are downloaded, they remain on the iPad.  I added a ‘clear memory’ button, so if you edit the input files and put the new versions on dropbox, you can get the new versions without reinstalling the app.  This erases the input files, but does not erase the output files.

If you are linked with dropbox, and have an internet connection, you can upload.  This uploads all the answered questionnaires, and removes the files from the iPad once dropbox confirms the upload.  If all files upload, the button title changes to 'upload complete'.  Sometimes it takes a little bit.  If there is an error, the button will not change, and you can push the button again.

iTunes can also be used to retrieve answers.

Once you’re done on this screen, hit ‘continue’ to select a questionnaire. If the app is linked to dropbox, and if there are questionnaires on dropbox that are not on the iPad, they will appear after everything downloads.

My guess is you would want to use these first two screens, then hand the iPad to the person answering the questionnaires.

Take a look at "sampleQuestionList.txt" for an idea how the question list should look.  A question list must have the extension '.txt' to work, and it must be ‘UTF8’ encoded.

The app will only rotate to portrait and portrait upside down, so that the formatting for multiple choice works.

The executable is called engagement because when it started it was an app to replace a questionnaire about engagement in math.

The text input file must be UTF-8 plain text.  NL, CR, and NL CR newlines should work.  The input file extension must be .txt and UTF-8 encoding.

Entries are separated by a <tab>.  Some text editors enter several spaces when you push the tab key, this will not work correctly.  If a line does not have <tab>s in it, it will be copied from the input file to the output file. This feature is not guaranteed to work, but if you try to use it an a block that is randomized by blocks, it will surely cause trouble. 

For generating input files, if you don’t use a spreadsheet, I recommend using TextEdit if you are on a mac.  Go to TextEdit -> Properties, and under the New Document tab, select Plain Text, and un-check smart quotes and smart dashes.  In the Open and Save tab, under plain text encoding, change the save file format to Unicode (UTF-8).  

The first line of the input file is a header line, use it to keep track of what is in which place. Also, include the file name that it is a header line for, and any info you think will be handy later.

On the next lines, the first entry is the question number.  The question numbers don’t have to be in order, but it keeps things much clearer if they are.  The header line is line number 0, the first question is line number 1, etc.


The second entry is a comment.  It can be whatever you want, and it can be pretty long.  Just so long as there are no <tab>s in it. It could be ‘numberline_spatialint1_level3’ … it just gets copied from the input file to the output file.

The third entry is ‘block’.  If block is 0, questions are presented to the user in the order that they appear in the input file.  A block is made up of all the lines that appear one after the other with the same block number.  A block is presented to the user in the order of the lines in the input file.  Blocks are randomized.  After a chunk of random blocks, there must be a line with block = 0.  The output file shows questions in the order that the user answered them.

The fourth entry is the type of question.  The question type is case sensitive.  Currently the valid question types are: numberline, wordFill, numberFill, instruction, picture, multipleChoice, speech, feedback, audioNumberline, titration, titrationBranch, branchTo, and branchOut.

The fifth entry is the time limit, in seconds.  A picture could be displayed for 600 milliseconds by making this entry 0.600 A time limit of -1 (or any number not greater than 0) means there is no time limit. branchTo lines don’t use a time limit, so the fifth entry is ignored.

If the time runs out, the answer is "Time ran out." followed by anything the user entered without pushing the submit button.

In a numberline question, entries are as follows   
	6: text of question.
       7: the text/number at the left end of the numberline.
	8: the text/number at the right end of the numberline.  

	The answer is a floating point number, 0 to 100.

At any point in a question or instruction, a new line can be started with the text &NL

In a wordFill question, 
       6: text of question.

In a numberFill question, 
       6: text of question.
       
The difference between this and a wordFill question is that the default keyboard is the one with numbers.

In an instruction, 
       6: text to display. 
       7: weather or not there is a continue button (yes or no).  
       
       If there is no continue button, it is important that there be a reasonable time limit.

In a picture, 
       6: the filename of the picture.  
       7: weather or not there is a continue button (yes or no).  
       
       The picture area is about 768 by 990 pixels, so if the ratio is about like that, the picture will take up most of the available space.  

In a multipleChoice question, 
       6: text of question.
       7: the first answer choice.
       
       There can be up to 12 choices.

In a speech question, 
       6: text to be displayed.
       7: time in seconds to pause before speech begins.
       8: text to convert to speech.
       9: time to pause between repeats.
       10: number of times to repeat.
       11: text field and continue button visible (yes/no).
       
The pause between saying something and repeating starts when the speech begins, not when it ends.  I will work on that, someday.  I used a speech synthesizer written at Carnegie Mellon.  The license is at the end of this document.

The speech synthesizer can say a number, if you give it ’13000’or ’13,000’ it will say ‘thirteen thousand’ but if you give it ‘13thousand’ it will be confused. 

Personally I hate it when people put the word ‘and’ all through numbers they are saying.  Makes it harder for me to understand the number.  But if you want the speech synthesizer to say things like ‘four hundred and fifteen thousand four hundred and six’ the only way I see to do that would be to write it out like that.  I also believe that any number larger than 999,999 should be expressed in scientific notation, but I guess I won’t make a case for doing that here.

In a branchOut question, 
       6: text of question.
       7: the first answer choice.
	8: the name of the input file to switch to if this choice is chosen.
	9: the line number in that input file to start with.
	
This is similar to a multiple choice question, but the answer picked by the user can cause the input file and line number to change. There can be up to 12 choices, for a total of 42 entries.  If time runs out, the current input file and next line number are used.

Any time the input file changes, the header line for the new input file marks where questions from the new input file start.

In a branchTo line,
	6: the name of the input file to switch to.
	7: the line number in that input file to start with.

A branchTo line is like a branchOut line, but it is not conditional.  If, for example, you want to ask a user questions in file1.txt, then file2.txt, you can make the last line in file1.txt be’ 8	15	0	branchTo	-1	file2.txt	0’

In an audioNumberLine question, 
	6: text of question.
       7: the text/number at the left end of the numberline.
	8: the text/number at the right end of the numberline.  
       9: time in seconds to pause before speech begins.
       10: text to convert to speech.
       11: time to pause between repeats.
       12: number of times to repeat.


In a feedback line,
	6: previous answer a user submitted.
	7: text to display if that is the previous answer.

This is repeated for the number of answer choices in the previous question.
A feedback line can only follow a multipleChoice or titration question. If you asked a user to choose between A,B,and C possible answer choices would be A,B,C,Time ran out.,Time ran out. A, Time ran out. B, Time ran out. C.  

The easiest way to deal with this confusion would be to not set a time limit on questions you plan to give feedback for.

In a titration question,
	6: The correct answer.
	7: spatial/verbal.
       8: text of question.
       9: the first answer choice.

There can again be up to 12 answer choices.

In a titrationBranch line,
	6: spatial/verbal.
	7: if the current level is this number.
	8: the name of the input file to switch to if at level.
	9: the line number to start with in that input file.

This can continue up through 5 levels.  A titrationBranch can be used a couple different ways:  If the user has answered 2 out of 3 questions correctly, the level increases.  At that point, a titrationBranch can be used to change to harder questions for the next level.  Another use is after the user’s level has been determined, a titrationBranch can be used to change to a list of questions for a person at that level.


The output file is formatted much like the input file. The extension is '.ans' 
The first line is the file name, which contains the name of the iPad, and the date and time the app was launched.  The output file has too more entries in it, the first is the answer from the user, the second is the time it was submitted.  The time format is Hour_minute_seccond.miliseconds.  The clock is 24 hour.

There are probably bugs.  Let me know if/when you find them.


                                                                     -Thad






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


                                          