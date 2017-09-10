package com.hotel.mail;

import com.hotel.util.DBProxy;
import com.hotel.util.StringGenerator;
import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

import java.sql.SQLException;

// put commons-email & commons-email javadoc in CATALINA_HOME\lib!
//very necessary to turn off Avast antivirus (firewall)
public class MailSender {
    private String lastSentCode;

    public String getLastSentCode() {
        return lastSentCode;
    }

    StringGenerator codeGenerator = new StringGenerator(8);
    public void send(String addressee, boolean isRegistration) throws EmailException, SQLException, Base64DecodingException {
        String recipient = addressee;

        String password = DBProxy.getInstance().getUserPassword("amely.honey@gmail.com", "Emails");
        String decodedPassword = new String(com.sun.org.apache.xml.internal.security.utils.Base64.decode(password));

        SimpleEmail email = new SimpleEmail();
        email.setSSL(true);
        email.setSSLOnConnect(true);
        email.setHostName("smtp.gmail.com");
        email.setAuthentication("amely.honey@gmail.com", decodedPassword);//"dctvbhyfzbcnjhbz");
        //email.setDebug(true);
        email.setSmtpPort(465); //587 for TLS

        email.addTo(recipient);
        email.setFrom("amely.honey@gmail.com", "Hotel Site");
        lastSentCode = codeGenerator.next();
        String content = "";

        if(isRegistration){
            email.setSubject("Registration code");
            content = "Hi, here is your code for registration " + lastSentCode + ".\nHave a nice day, sincerely Yours, Hotel Site team.";
        }
        else {
            email.setSubject("Reset password code");
            content = "Hi, here is your code for reset password " + lastSentCode + ".\nHave a nice day, sincerely Yours, Hotel Site team.";
        }

        email.setMsg(content);
        email.send();
    }
}

