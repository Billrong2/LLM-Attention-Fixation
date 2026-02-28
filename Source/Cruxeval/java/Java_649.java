import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_649 {
    public static String f(String text, long tabsize) {
        String[] lines = text.split("\n");
        ArrayList<String> output = new ArrayList<>();
        for (String line : lines) {
            output.add(line.replaceAll("\t", " ".repeat((int) tabsize)));
        }
        return String.join("\n", output);
    }
    public static void main(String[] args) {
    assert(f(("	f9\n	ldf9\n	adf9!\n	f9?"), (1l)).equals((" f9\n ldf9\n adf9!\n f9?")));
    }

}
