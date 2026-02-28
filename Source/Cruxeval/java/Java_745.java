import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_745 {
    public static String f(String address) {
        int suffix_start = address.indexOf('@') + 1;
        if (address.substring(suffix_start).chars().filter(ch -> ch == '.').count() > 1) {
            address = address.replace(address.substring(suffix_start), String.join(".", Arrays.asList(address.split("@")[1].split("\\.", 2))));
        }
        return address;
    }
    public static void main(String[] args) {
    assert(f(("minimc@minimc.io")).equals(("minimc@minimc.io")));
    }

}
