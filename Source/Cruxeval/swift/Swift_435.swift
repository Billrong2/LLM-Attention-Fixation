func f(numbers: [String], num: Int, val: Int) -> String {
    var numbers = numbers
    let valStr = String(val)
    
    // Ensure num is greater than 0 to avoid division by zero
    if num > 0 {
        while numbers.count < num {
            numbers.insert(valStr, at: numbers.count / 2)
        }
        
        if num > 1 {
            for _ in 0..<(numbers.count / (num - 1) - 4) {
                numbers.insert(valStr, at: numbers.count / 2)
            }
        }
    }
    
    return numbers.joined(separator: " ")
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
            
assert(f(numbers: [] as [String], num: 0, val: 1) == "")
