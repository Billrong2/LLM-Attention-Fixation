import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_222 {
    public static String f(String mess, String character) {
        while (mess.indexOf(character, mess.lastIndexOf(character) + 1) != -1) {
            mess = mess.substring(0, mess.lastIndexOf(character) + 1) + mess.substring(mess.lastIndexOf(character) + 2);
        }
        return mess;
    }
    public static void main(String[] args) {
    assert(f(("0aabbaa0b"), ("a")).equals(("0aabbaa0b")));
    }

}
