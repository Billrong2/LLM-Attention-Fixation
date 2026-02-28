import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_700 {
    public static long f(String text) {
        return text.length() - text.split("bot", -1).length + 1;
    }
    public static void main(String[] args) {
    assert(f(("Where is the bot in this world?")) == (30l));
    }

}
