# FirebaseMessagingApp (The app will be ready soon I'm working to open source it.)
This is a professional real time messaging app using firebase for both android(java)(adnroid studio) and iOS(xcode)(swift). Actually I built this messenger while developing my fungi app, so feel free to use it developers.<b> Notice that this is not a whole application just the files necessary for the chat application.</b>


#How To Use The App

<h2> Again this is not the whole application just the files neccessary for the chat application so you just have to add these files to your project</h2>
<h2> You may have issues with compatibality with your development kit such as sdk version or deployment target, if you have this kind of issues, alternate the code causes the issues with code compatible with your settings</h2>

<h2>Android</h2>
<h4> Dependencies Used</h4>
<p> I included the gradle file, notice that not all the dependcies needed for the messaging app <b>only the first four.</b></p>

<h4> Android Other Files</h4>

<p><b>. </b>Inside the Android folder there is the Chat.java activity that contains the code for the chat app <b> please make                                sure the theme for this activity in the manifest file comes with action bar</b> and <b> make sure that you change the reference of the firebase to your firebase to get your messages</b></p>


<p><b>. </b>Also there is the activity_chat layout that contains the list of the messages and the input field to add messages</p>
<p><b>. </b>There are also two other layout files(message_left.xml and message.xml) these are the layout for every message,      message_left.xml the design for the left message(the person you chat with), and message.xml the design for the right message (your messages)</p>
<p><b>. </b>On the drawable folder there is two files <b>bg_msg_from1.xml</b> and <b>bg_msg_from_left.xml</b> that related to the buuble background of the messages and from these files you can change the colors of the right and left messages</p>
<h4>Copy the mentioned above to your app and that chat app is ready</h4>

<h2>iOS</h2>
<p> <b>. </b>Inside the iOS folder there is SendMessageViewController.swift this files contains all the code for the app and also create the views for the app.</p>
<p> <b>. </b> Notice I did not include the storyboard file so you just have to create an empty CollectionView and make SendMessageViewController the class of it.</p>

#Requirments
<h4><b>1-</b> Knowing how to work with firebase on android or iOS to change the reference of the firebase to your database, modify the code to your own taste and understand how the code works.</h4>
<h4> <b>2- </b> knowing how to work with either iOS (swift)(xcode) or android(java)(android studio),understand the code, fix the errors and modify the code </h4>
<h4><b>3- </b>Have a previous experience with git and github to clone this project and inform me if there are errors in my code occured in your side.</h4>
