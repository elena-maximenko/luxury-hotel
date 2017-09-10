package com.hotel.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validator {
    public static final String REGEX_NAME = "([A-Z][a-z]*)|([А-Я][а-я]*)";
    public static final String REGEX_LOGIN = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";//"[-a-z0-9!#$%&'*+/=?^_`{|}~]+(\\\\.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@([a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?\\\\.)*(aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])";
    public static final String REGEX_DIGITS = "[0-9]{1,}";
    public static final String REGEX_UPPERCASE = "([A-Z]|[А-Я]){1,}";
    public static final String REGEX_PASSWORD = "(.){8,}";
    public static final String REGEX_DOUBLE = "[0-9]{1,13}(\\\\.[0-9]*)?";

    public boolean isCorrectParameter(String parameter, String regex, boolean isPassword){
        parameter.trim();
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(parameter);
        if(isPassword){
                return matcher.find();
        }
        else{
            return matcher.matches();
        }
    }

    public static int indexOfUpperCase(String string){
        for (int i = 0; i < string.length(); i++){
            if(Character.isUpperCase(string.charAt(i))){
                return i;
            }
        }
        return -1;
    }
}
