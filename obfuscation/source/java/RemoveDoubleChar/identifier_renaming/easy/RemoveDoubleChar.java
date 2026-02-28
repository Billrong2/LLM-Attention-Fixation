
class RemoveDoubleChar {

    public static void main(String[] args) {
        System.out.println("");
        System.out.println("ll nn ss ee");
        System.out.println("");
        System.out.println("Nashvie, Tee");
        System.out.println("");
        String v1 = "Nashville, Tennessee";
        String v2 = removeDoubleCharacters(v1);
        System.out.println(v2);
    }

    public static String removeDoubleCharacters(String str) {
        if (str.isEmpty()) {
            return str;
        }

        StringBuilder v1 = new StringBuilder();

        char v2 = str.charAt(0);
        v1.append(v2);
        for (int v3 = 1; v3 < str.length(); v3++) {
            char v4 = str.charAt(v3);
            if (v2 != v4) {
                v1.append(str.charAt(v3));
            }
            v2 = v4;
        }

        return v1.toString();
    }

}
