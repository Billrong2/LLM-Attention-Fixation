/// 
func f(letters: [String]) -> String {
    var a: [String] = []
    for i in 0..<letters.count {
        if a.contains(letters[i]) {
            return "no"
        }
        a.append(letters[i])
    }
    return "yes"
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
            
assert(f(letters: ["b", "i", "r", "o", "s", "j", "v", "p"]) == "yes")
