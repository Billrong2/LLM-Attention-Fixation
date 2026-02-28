import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_433 {
    public static String f(String text) {
        String[] texts = text.split(",");
        List<String> textList = new ArrayList<>(Arrays.asList(texts));
        
        textList.remove(0);
        int indexOfT = textList.indexOf("T");
        textList.add(0, textList.remove(indexOfT));

        return "T," + String.join(",", textList);
    }
    public static void main(String[] args) {
    assert(f(("Dmreh,Sspp,T,G ,.tB,Vxk,Cct")).equals(("T,T,Sspp,G ,.tB,Vxk,Cct")));
    }

}
