private static String _obfConstDecodeB64(String s) {
    return new String(java.util.Base64.getDecoder().decode(s));
}

private static int _obfConstDecodeInt(int v, int key) {
    return v ^ key;
}
