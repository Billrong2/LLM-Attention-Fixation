import java.util.*;
import java.lang.reflect.*;
import org.javatuples.*;
import java.security.*;
import java.math.*;
import java.io.*;
import java.util.stream.*;
class Java_194 {
    public static ArrayList<ArrayList<Long>> f(ArrayList<ArrayList<Long>> matr, long insert_loc) {
        matr.add((int)insert_loc, new ArrayList<>());
        return matr;
    }
    public static void main(String[] args) {
    assert(f((new ArrayList<ArrayList<Long>>(Arrays.asList((ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)5l, (long)6l, (long)2l, (long)3l)), (ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)1l, (long)9l, (long)5l, (long)6l))))), (0l)).equals((new ArrayList<ArrayList<Long>>(Arrays.asList((ArrayList<Long>)new ArrayList<Long>(Arrays.asList()), (ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)5l, (long)6l, (long)2l, (long)3l)), (ArrayList<Long>)new ArrayList<Long>(Arrays.asList((long)1l, (long)9l, (long)5l, (long)6l)))))));
    }

}
