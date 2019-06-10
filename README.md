# **ScreenFree**

**ScreenFree Demo:**
A demo of Screenfree can from this google drive download link: https://drive.google.com/open?id=1w8neWx0greyahXlaEKPZHVTkpP-XVCH7

**Mission Statement:** Our mission is to help enrich the daily lives of individuals and communities through the responsible use of social technology. At ScreenFree, we value organic relationships and believe that it is crucial to the wellbeing of our families and communities. With the advent of social media, humanity is redefining what it means to communicate with each other. ScreenFree works to embrace technology as the solution to finding the balance between physical and digital personal interactions. 

**Problem Statement:** Communities are growing more impersonal as the daily use of social technology continues to increase. The demand of a solution to creating and maintaining more meaningful relationships grows as more social media users are leaving the platforms in favor of face to face interactions. ScreenFree is the technological solution to helping the user form and maintain better social media habits.  <br />


**Team Roles:** <br />
Architect: Patrick Stewart <br />
Developer: Daniel Bobrovnikov <br />
Developer: Nicole Zeck


**Scoped Down Problem, Solution and Typical User Info:** <br />
Scoped Down Problem: Social media users are becoming concerned with the amount of time spent on social media platforms and have a hard time limiting themselves.<br />
Solution: Provide an application that would help track time spent on social media platforms and limit the time a person can spend on them.<br />
Typical User: any person who is concerned with spending too much time on social media and wants to do something about it.<br />

The features will include:<br />
-User login and creation <br />
-Create, add, or remove domains to be blocked a user specified time. <br />
-Display performance metrics in a graph or Chart<br />
-Monitor and block domains at a user specified time<br />
-Share Metric Results with other users <br />

**Architectural Diagrams**<br />
*Note these have changed after implementing the architecture and can be found in the directory and can be found in the "Legacy Architecure Diagrams" directory

**Revised Architecture Diagrams** <br />
The app now follows the AWS cloud computing standard mobile architecture pattern as best shown here <br />
![alt text](https://github.com/se577/ScreenFree/blob/master/awsCognitoArchitecture.png?raw=true) <br />

**Design Patterns and Tactics**:<br />
Our group will be using the Multi-Tier design pattern for our app. The app follows a user login authentication data flow from client, web, server, and back-end tier in order to complete tasks and requests.  We will follow a standard user login key development with a back end database that will store or app data for tasks as well as user metrics. <br />

Users will be able to create a profile that will store URL domains and times they wish to have them blocked. The app will also keep metrics such as total time the user has had the app blocked and display the information in the app in a chart or graph. All the processes will follow the pattern of user key to data item stored in the database. The multi-tier pattern will facilitate and define the interfaces of all the requests our app can make such as adding/removing domains to the user's lists. The design pattern also caters to our need to decouple the back end to the app user front end. The actual URL blocking will be done locally on the app as the database and servers only tasks will be supplying the URLs and user information.<br />

**Instructions for building and Running**:<br />
A user must have a MAC computer with Xcode 10 installed  <br />
The general swift envirnoment setup instructions can be found on AWS here: <br />
https://docs.aws.amazon.com/aws-mobile/latest/developerguide/mobile-hub-getting-started.html#mobile-hub-add-aws-mobile-sdk-connect-to-your-backend <br />

For this app you need to install AWS Prerequisites with Cocoapods from a terminal <br />

Open a terminal window and use the run: <br />
sudo gem install cocoapods <br />

Now navigate to this xcode project directory that contains .xcodeproj and run: <br />
pod setup

I have include my podfile so you should then only need to run the following command to add the pod files to your project: <br />
pod install --repo-update  <br />

Now you you can open the xcode project using the .xcworkspace file NOT .xcodeproj file <br />

Within Xcode do a clean and a build then select the iPhone 8 as the simulator and run the project.<br />
