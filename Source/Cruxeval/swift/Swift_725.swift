/// 
func f(text: String) -> Int {
    var result_list = ["3", "3", "3", "3"]
    if !result_list.isEmpty {
        result_list.removeAll()
    }
    return text.count
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
            
assert(f(text: "mrq7y") == 5)
