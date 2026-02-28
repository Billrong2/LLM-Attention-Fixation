import java.io.*;
import java.lang.reflect.*;
import java.math.*;
import java.security.*;
import java.util.*;
import java.util.stream.*;
import org.javatuples.*;
import java.util.*;

class Java_089 {
    public static String f(String inputChar) {
        if (!"aeiouAEIOU".contains(inputChar)){
            return null;
        }
        if ("AEIOU".contains(inputChar)){
            return inputChar.toLowerCase();
        }
        return inputChar.toUpperCase();
    }
    public static void main(String[] args) {
    assert(f(("o")).equals(("O")));
    }

}
