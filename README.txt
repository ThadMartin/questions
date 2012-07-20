Using the questionnaires app:

The app will only rotate to portrait and portrait upside down, so that the formatting for multiple choice works.The text input file must be UTF-8 plain text.  NL, CR, and NL CR newlines should work, but this is not thoroughly tested.

Entries are separated by a <tab>.  Some text editors enter several spaces when you push the tab key, this will not work correctly.

There should be a single newline at the end of the input file.

The first line of the input file is a header line, use it to keep track of what is in which place.

On the next lines, the first entry is the question number.  The second entry is the condition. The third entry is the type of question.  The question type is case sensitive.  Currently the valid question types are: numberline, wordFill, numberFill, instruction, picture, and multipleChoice.

The fourth entry is the time limit.  A time limit of -1 means there is no time limit.  

If the time runs out, the answer is "Time ran out. " followed by anything the user entered without pushing the submit button.

In a numberline question, the fifth entry is the question, the sixth entry is the text at the left end of the numberline, and the seventh entry is the text at the right end of the numberline.  The answer is a floating point number, 0 to 100.

At any point in a question or instruction, a new line can be started with the text &NL

In a wordFill question, the fifth entry is the question.

In a numberFill question, the fifth entry is the question.  The difference between this and a wordFill question is that the default keyboard is the one with numbers.

In an instruction, the fifth entry is the instruction.

In a picture, the fifth entry is the filename of the picture.  The picture area is about 768 by 990 pixels, so if the ratio is about like that, the picture will take up most of the space it can.  

In a multipleChoice question, the fifth entry is the question.  This can be followed by up to 12 entries, which are choices.

The output file is formatted much like the input file.  The first line is the file name, which contains the name of the iPad, and the date and time the app was launched.  The output file has too more entries in it, the first is the answer from the user, the second is the time it was submitted.

In the code, in engagementViewController.m, in viewDidAppear, the two lines of code below can be commented to give a choice about linking to dropbox, or uncommented to connect automatically to dropbox if the app is linked. 

 //comment the lines below to show the screen to unlink from a dropbox account.
    
   //  if ([[DBSession sharedSession] isLinked])
   //      [self performSegueWithIdentifier: @"toQuestionSelector" sender: self]; 
In the code, in engagementAppDelegate.m, in didFinishLaunchingWithOptions, there are lines that begin with"initWithAppKey" and "appSecret".
These lines can be modified with an app key and an app secret that you can get from 
https://www.dropbox.com/developers
if you want to link the program with a dropbox account that is not the ATR dropbox account.  
Go to "MyApps" and add an app for questionnaires.  It will give you the keys.
Once you have the keys, put them in engagementAppDelegate.m
You may also need to create folders named "upload" and "download" in the app's folder.

A question list can be local, or on dropbox.  If it is in dropbox, it must be in the folder named "download".  Getting a question list from dorpbox sometimes takes a few seconds… wait for it.

Take a look at "sampleQuestionList.txt" for an idea how the question list should look.  A question list must have the extension .txt to work.

As of 7-2012, this code has not been tested much (it worked once or twice) and I'm new at iOS programming.  If you find any bugs, or have any suggestions, you can email me at martin_thad@yahoo.com

