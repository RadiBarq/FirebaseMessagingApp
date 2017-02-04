# FirebaseMessagingApp
This is a professional real time messaging app using firebase for both Android (java, adnroid studio) and iOS (xcode, swift). I built this messenger while developing my fungi app, so feel free to use it.<b> Notice that this is not the whole app just the files necessary for the chat.</b>


#How To Use The App
<h2> Again this is not the whole app just the files neccessary for the chat so you should add these files to your project</h2>
<h2> You may have compatibality issues with your development kit such as sdk version or deployment target, if you have this kind of issues, change the code that causes this issues with code compatible with your settings. I attached the gradle file  for android, and for iOS the deployment target is <b>10</b>. If you still have issues, please contact me here or on my email <b>grayllow@gmail.com</b></h2>.
<h2>Android</h2>
<h4> Dependencies Used</h4>
<p> I include the gradle file inside the android folder, notice that <b>only the first four depencies needed for the app.</b>

<h4>Included Files</h4>
<p><b>. </b>Inside the Android folder there is the Chat.java activity that contains the code for the chat app <b> please make sure the theme for this activity in the manifest file comes with action bar</b> and <b> make sure that you change the reference of the firebase to your firebase to get your messages</b></p>
<p><b>. </b>Also there is the activity_chat layout that contains the list of the messages and the input field to add messages</p>
<p><b>. </b>There are also two other layout files(message_left.xml and message.xml) these are the layouts for every message.      message_left.xml the design for the left message(the person you chat with), and message.xml the design for the right message (your messages)</p>
<p><b>. </b>On the drawable folder there is two files <b>bg_msg_from1.xml</b> and <b>bg_msg_from_left.xml</b> these files related to the bubble background of the messages and from these files you can change the colors of the right and left messages</p>
<h4>Copy the mentioned above to your app and the chat app is ready.</h4>
<h2>iOS</h2>
<p> <b>. </b>Inside the iOS folder there is SendMessageViewController.swift this file that contains all the code for the app and also create the views programmatically for the app.</p>
<p> <b>. </b> Notice I did not include the storyboard file because you just have to create an empty CollectionView and make SendMessageViewController the class of it.</p>
<p> <b>. </b> There are also the Message.swift that cointains the message components.</p>
<p> <b>. </b> There are also the ChatMessageCell.swift that have the cell design components.</p>
<p> <b>. </b> Finally in the assests folder there is the profile image picture for the chat app, actually this is a static image that does not change with every user so you may want to improve the app and malke it change the picture for every user.</p>
<h4>Copy the mentioned above to your app and the chat app is ready.</h4>
#Requirments
<h4><b>1-</b> Knowing how to work with firebase on android or iOS to change the reference of the firebase to your database, modify the code to your own taste and understand how the code works.</h4>
<h4> <b>2- </b> knowing how to work with either iOS (swift)(xcode) or android(java)(android studio),understand the code, fix the errors and modify the code </h4>
<h4><b>3- </b>Have a previous experience with git and github to clone this project and inform me if there are errors in my code occured in your side.</h4>

