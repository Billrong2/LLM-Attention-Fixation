/// 
func f(string: String) -> String {
    if string.isEmpty || !string.prefix(1).allSatisfy({ $0.isNumber }) {
        return "INVALID"
    }
    
    var cur = 0
    for char in string {
        if let number = Int(String(char)) {
            cur = cur * 10 + number
        }
    }
    
    return String(cur)
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
            
assert(f(string: "3") == "3")
