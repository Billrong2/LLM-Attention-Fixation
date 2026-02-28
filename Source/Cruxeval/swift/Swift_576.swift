func f(array: [Int], const: Int) -> [String] {
    var output: [String] = ["x"]
    for i in 1...array.count {
        if i % 2 != 0 {
            output.append(String(-2 * array[i - 1]))
        } else {
            output.append(String(const))
        }
    }
    return output
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
            
assert(f(array: [1, 2, 3], const: -1) == ["x", "-2", "-1", "-6"])
