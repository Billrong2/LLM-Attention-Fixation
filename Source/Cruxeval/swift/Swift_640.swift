func f(text: String) -> Int {
    var a = 0
    let textArray = Array(text)
    
    if textArray.count > 1 && textArray[1...].contains(textArray[0]) {
        a += 1
    }
    
    for i in 0..<textArray.count - 1 {
        if textArray[(i + 1)...].contains(textArray[i]) {
            a += 1
        }
    }
    
    return a
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
            
assert(f(text: "3eeeeeeoopppppppw14film3oee3") == 18)
