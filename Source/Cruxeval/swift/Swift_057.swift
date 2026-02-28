/// 
func f(text: String) -> Int {
    var text = text.uppercased()
    var count_upper = 0
    for char in text {
        if char.isUppercase {
            count_upper += 1
        } else {
            return -1
        }
    }
    return count_upper / 2
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
            
assert(f(text: "ax") == 1)
