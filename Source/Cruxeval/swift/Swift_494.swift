func f(num: String, l: Int) -> String {
    var t = ""
    var remainingLength = l
    while remainingLength > num.count {
        t += "0"
        remainingLength -= 1
    }
    return t + num
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
            
assert(f(num: "1", l: 3) == "001")
