func f(st: String) -> String {
    if st.first == "~" {
        let e = String(repeating: "s", count: max(0, 10 - st.count)) + st
        return f(st: e)
    } else {
        return String(repeating: "n", count: max(0, 10 - st.count)) + st
    }
}


func ==(left: [(Int, Int)], right: [(Int, Int)]) -> Bool {
    if left.count != right.count {
        return false
    }
    for (l, r) in zip(left, right) {
        if l != r {
            return false
        }
    }
    return true
}
            
assert(f(st: "eqe-;ew22") == "neqe-;ew22")
