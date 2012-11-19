Using the questionnaires app:

Dropbox automatically retries any uploads or downloads that time out.  

Pictures are centered if they are smaller than the picture view, and resized to fit if they are larger.

The first screen you see has buttons for linking, unlinking, uploading to dropbox, downloading from dropbox, and clearing previously downloaded questions. You can also continue to the question selector or quit.

This version is linked to the algebraresearch@gmail.com dropbox account, and uses folders /Apps/questionnaires2/uploadNumberStims and /Apps/questionnaires2/downloadNumberStims  

Download and upload are from the perspective of the iPad.  

My guess is that the person administering experiments will use these first two screens, then hand the iPad to the person answering the questionnaires.

A question list must have the extension '.txt' to work, and it must be UTF8 encoded.  It is possible to use a list of question files, this must have a .ord extension.  Again, it must be UTF8.

The app will only rotate to portrait and portrait upside down, so that the formatting for multiple choice works.

Entries are separated by a <tab>. 

The first line of the input file is a header line, use it to keep track of what is in which place. Also, include the file name that it is a header line for, and any info you think will be handy later.  The header line must start with the word head.

On the next lines, the first entry is the question number.  The question numbers do not have to be in order, and do not even have to be numbers.  If they are sequential numbers though, it should make everything easier to keep track of.  If jumping to a line number, the app thinks of the header line is line number 0, the first question is line number 1, etc.

The second entry is a comment.  It can be whatever you want, just so long as there are no <tab>s in it. 

The third entry is block.  If block is 0, questions are presented to the user in the order that they appear in the input file.  A block is made up of all the lines that appear one after the other with the same block number.  A block is presented to the user in the order of the lines in the input file.  Blocks are randomized.  After a chunk of random blocks, there must be a line with block = 0.  The output file shows questions in the order that the user answered them.

The fourth entry is the type of question.  The question type is case sensitive.  Currently the valid question types are: numberline, wordFill, numberFill, instruction, picture, multipleChoice, speech, feedback, audioNumberline, titration, titrationBranch, branchTo, and branchOut.

The fifth entry is the time limit, in seconds.  A picture could be displayed for 600 milliseconds by making this entry 0.600 A time limit of -1 (or any number not greater than 0) means there is no time limit. branchTo and titrationBranch do not use a time limit, so the fifth entry is ignored.

If the time runs out, the answer is "Time ran out." followed by anything the user entered without pushing the submit button.

At any point in a question or instruction, a new line can be started with the text &NL

In a numberline question, entries are as follows   
	6: text of question.
        7: the text/number at the left end of the numberline.
	8: the text/number at the right end of the numberline.  

	The answer is a floating point number, 0 to 100.

In a wordFill question, 
       6: text of question.

In a numberFill question, 
       6: text of question.
       
	The difference between this and a wordFill question is that the default keyboard is the one with numbers.

In an instruction, 
       6: text to display. 
       7: weather or not there is a continue button (yes or no).  
       8: is it a large and centered word (yes or no).
       
       If there is no continue button, it is important that there be a reasonable time limit.

In a picture, 
       6: the filename of the picture.  
       7: weather or not there is a continue button (yes or no).  
       
       The picture area is about 728 by 853 pixels, so if the ratio is about like that, the picture will take up most of the available space.  

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
       11: continue button visible (yes or no).
       12 label visible (yes or no).
       13 text input visible (yes or no).
       
       The pause between saying something and repeating starts when the speech begins, not when it ends.  I will work on that, someday.  I used a speech synthesizer written at Carnegie Mellon.  The license is at the end of this document.


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

         A branchTo line is like a branchOut line, but it is not conditional. 

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
	7: (spatial or verbal).
        8: text of question.
        9: the first answer choice.

        There can again be up to 12 answer choices.

In a titrationBranch line,
	6: (spatial or verbal).
	7: if the current level is this number.
	8: the name of the input file to switch to if at level.
	9: the line number to start with in that input file.

         This can continue up through 5 levels.  A titrationBranch can be used a couple different ways:  If the user has answered 2 out of 3 questions correctly, the level increases.  At that point, a titrationBranch can be used to change to harder questions for the next level.  Another use is after the users level has been determined, a titrationBranch can be used to change to a list of questions for a person at that level.


The output file is formatted much like the input file. The extension is '.ans' 
The first line is the file name, which contains the name of the iPad, and the date and time the app was launched.  The output file has too more entries in it, the first is the answer from the user, the second is the time it was submitted.  The time format is Hour_minute_seccond.miliseconds.  The clock is 24 hour.

There are probably bugs.  Let me know if/when you find them.


-Thad






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

