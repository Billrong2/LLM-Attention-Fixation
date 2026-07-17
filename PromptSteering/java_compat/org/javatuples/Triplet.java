package org.javatuples;

import java.io.Serializable;
import java.util.Objects;

public final class Triplet<A, B, C> implements Serializable {
    private static final long serialVersionUID = 1L;

    private final A value0;
    private final B value1;
    private final C value2;

    public Triplet(A value0, B value1, C value2) {
        this.value0 = value0;
        this.value1 = value1;
        this.value2 = value2;
    }

    public static <A, B, C> Triplet<A, B, C> with(A value0, B value1, C value2) {
        return new Triplet<>(value0, value1, value2);
    }

    public A getValue0() {
        return value0;
    }

    public B getValue1() {
        return value1;
    }

    public C getValue2() {
        return value2;
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof Triplet<?, ?, ?>)) {
            return false;
        }
        Triplet<?, ?, ?> triplet = (Triplet<?, ?, ?>) other;
        return Objects.equals(value0, triplet.value0)
            && Objects.equals(value1, triplet.value1)
            && Objects.equals(value2, triplet.value2);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value0, value1, value2);
    }

    @Override
    public String toString() {
        return "(" + value0 + ", " + value1 + ", " + value2 + ")";
    }
}
