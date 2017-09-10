package com.hotel.util;

import java.util.Random;

public class StringGenerator {

    private static final char[] symbols;

        static {
            StringBuilder tmp = new StringBuilder();
            for (char ch = '0'; ch <= '9'; ch++) {
                tmp.append(ch);
            }
            for (char ch = 'a'; ch <= 'z'; ch++) {
                tmp.append(ch);
            }
            for (char ch = 'A'; ch <= 'Z'; ch++){
                tmp.append(ch);
            }
            symbols = tmp.toString().toCharArray();
        }

        private final Random random = new Random();

        private final char[] buf;

        public StringGenerator(int length) {
            if (length < 1) {
                throw new IllegalArgumentException("length < 1: " + length);
            }
            buf = new char[length];
        }

        public String next() {
            for (int i = 0; i < buf.length; i++) {
                buf[i] = symbols[random.nextInt(symbols.length)];
            }
            return new String(buf);
        }
}
