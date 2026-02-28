/// 
func f(text: String) -> Int {
    var count = 0
    for i in text {
        if ".?!.,".contains(i) {
            count += 1
        }
    }
    return count
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
            
assert(f(text: "bwiajegrwjd??djoda,?") == 4)
