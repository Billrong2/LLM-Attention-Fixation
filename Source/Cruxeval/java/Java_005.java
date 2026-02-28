import org.javatuples.Pair;

class Java_005 {
    public static Pair<Long, String> f(String text, String lower, String upper) {
        long count = 0;
        StringBuilder new_text = new StringBuilder();
        for (char c : text.toCharArray()) {
            char charToAppend = Character.isDigit(c) ? lower.charAt(0) : upper.charAt(0);
            if (charToAppend == 'p' || charToAppend == 'C') {
                count += 1;
            }
            new_text.append(charToAppend);
        }
        return Pair.with(count, new_text.toString());
    }
    public static void main(String[] args) {
    assert(f(("DSUWeqExTQdCMGpqur"), ("a"), ("x")).equals((Pair.with(0l, "xxxxxxxxxxxxxxxxxx"))));
    }

}
