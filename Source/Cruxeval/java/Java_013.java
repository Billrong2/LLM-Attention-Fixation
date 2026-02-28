import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_013 {
    public static long f(ArrayList<String> names) {
        int count = names.size();
        int numberOfNames = 0;
        for (String name : names) {
            if (name.matches("[a-zA-Z]+")) {
                numberOfNames++;
            }
        }
        return numberOfNames;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<String>(Arrays.asList((String)"sharron", (String)"Savannah", (String)"Mike Cherokee")))) == (2l));
    }

}
