private static interface _ObfFn1<A, R> {
    R apply(A a);
}

private static <A, R> R _obfDispatch(java.util.Map<Integer, _ObfFn1<A, R>> m, int key, A a) {
    return m.get(key).apply(a);
}
