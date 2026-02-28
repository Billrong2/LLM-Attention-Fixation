/// 
func f(phrase: String) -> Int {
    var ans = 0
    for word in phrase.split(separator: " ") {
        for char in word {
            if char == "0" {
                ans += 1
            }
        }
    }
    return ans
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
            
assert(f(phrase: "aboba 212 has 0 digits") == 1)
