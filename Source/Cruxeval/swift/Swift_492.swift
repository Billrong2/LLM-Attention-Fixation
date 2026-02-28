/// 
func f(text: String, value: String) -> String {
    var ls = Array(text)
    if ls.filter({ $0 == Character(value) }).count % 2 == 0 {
        while ls.contains(Character(value)) {
            if let index = ls.firstIndex(of: Character(value)) {
                ls.remove(at: index)
            }
        }
    } else {
        ls.removeAll()
    }
    return String(ls)
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
            
assert(f(text: "abbkebaniuwurzvr", value: "m") == "abbkebaniuwurzvr")
