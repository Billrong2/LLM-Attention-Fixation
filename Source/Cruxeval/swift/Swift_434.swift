/// 
func f(string: String) -> Int {
    if let lastIndex = string.lastIndex(of: "e") {
        return string.distance(from: string.startIndex, to: lastIndex)
    } else {
        return -1
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
            
assert(f(string: "eeuseeeoehasa") == 8)
