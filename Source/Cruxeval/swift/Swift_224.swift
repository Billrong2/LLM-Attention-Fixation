func f(array: [String], value: Int) -> [String : Int] {
    var reversedArray = Array(array.reversed())
    _ = reversedArray.popLast()
    var odd: [[String: Int]] = []
    while !reversedArray.isEmpty {
        var tmp: [String: Int] = [:]
        if let last = reversedArray.popLast() {
            tmp[last] = value
            odd.append(tmp)
        }
    }
    
    var result: [String: Int] = [:]
    while !odd.isEmpty {
        if let dict = odd.popLast() {
            for (key, value) in dict {
                result[key] = value
            }
        }
    }
    
    return result
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
            
assert(f(array: ["23"], value: 123) == [:] as [String : Int])
