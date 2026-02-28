/// 
func f(text: String) -> String {
    var ans = ""
    for char in text {
        if char.isNumber {
            ans.append(char)
        } else {
            ans.append(" ")
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
            
assert(f(text: "m4n2o") == " 4 2 ")
