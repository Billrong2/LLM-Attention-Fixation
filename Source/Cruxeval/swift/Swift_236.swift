/// 
func f(array: [String]) -> String {
    if array.count == 1 {
        return array[0]
    }
    var result = array
    var i = 0
    while i < array.count - 1 {
        for _ in 0..<2 {
            result[i * 2] = array[i]
            i += 1
        }
    }
    return result.joined()
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
            
assert(f(array: ["ac8", "qk6", "9wg"]) == "ac8qk6qk6")
