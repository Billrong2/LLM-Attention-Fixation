package org.javatuples;

import java.io.Serializable;
import java.util.Objects;

public final class Pair<A, B> implements Serializable {
    private static final long serialVersionUID = 1L;

    private final A value0;
    private final B value1;

    public Pair(A value0, B value1) {
        this.value0 = value0;
        this.value1 = value1;
    }

    public static <A, B> Pair<A, B> with(A value0, B value1) {
        return new Pair<>(value0, value1);
    }

    public A getValue0() {
        return value0;
    }

    public B getValue1() {
        return value1;
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof Pair<?, ?>)) {
            return false;
        }
        Pair<?, ?> pair = (Pair<?, ?>) other;
        return Objects.equals(value0, pair.value0) && Objects.equals(value1, pair.value1);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value0, value1);
    }

    @Override
    public String toString() {
        return "(" + value0 + ", " + value1 + ")";
    }
}
