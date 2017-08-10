About this site
---------------

  This is site of hotel. If you are a registered user, you can watch the rooms in hotel and pick one you want. Also if it is complicated decision for you, you will be able to send a request to manager of hotel with information about room you want. In this case manager will pick the most suitable room for you according to request you've sent.
  
Installation
------------

  What you need for using the site is the set up JDK and SDK up to 8th version inclusively, the Tomсat container all versions before 9th one and IDE for Java.
  Also You will need to download some jars like:
  1) commons-email-1.4.jar;
  2) org.apache.commons.io.jar;
  3) mysql-connector-java-5.1.42-bin.jar;
  4) log4j.jar;
  5) commons-email-1.4-javadoc.jar;
  6) commons-fileupload.jar;
  
  Then put all mentioned above jars in your {CATALINA_HOME}\lib directory.
  
  Also please while working with this web application don't forget to turn off your antivirus software. It may be obstacle for sending letters on your email from current web application.
  You should allow receiving letters from insecure applications in setting of your email account.
  
  When You have opened this project in IDE, You will see the Database panel in the right.
  Click "Synchronize".
  
  When You have deployed this application successfully in URL of browser you will see something like this one: http://localhost:8084. You should add to this URL text "/luxury-hotel" and you will see the start page. So, to get started working with current application URL like http://localhost:8084/luxury-hotel is required.
  
  Some application info about users to work with:
  1) admin: login - amely.honey@gmail.com, password - L1234567. 
  2) manager: login - dimalevak96@gmail.com, password - D1234567.
  
Libraries and modules
---------------------
    
    There is only one module in this application. It is named SummaryTask4. In current application Tomcat, MySQL, Log4j, commons-email, commons-fileupload, commons-io are used.
    Test for this web site via JUnit are planned.
    
    Also as there is only one admin page yet, pages for Manager and Client'll be designed.
    Adding Maven support is considered.
    
 Authors and contacts
 -----------------

  Author: Elena Maximenko.
  Contacts: amely.honey@gmail.com
            https://www.linkedin.com/in/elena-maximenko-76939a12a/
    
    
  
