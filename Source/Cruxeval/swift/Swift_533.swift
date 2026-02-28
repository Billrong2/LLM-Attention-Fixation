/// 
func f(query: String, base: [String : Int]) -> Int {
    var net_sum = 0
    for (key, val) in base {
        if key.first == Character(query) && key.count == 3 {
            net_sum -= val
        } else if key.last == Character(query) && key.count == 3 {
            net_sum += val
        }
    }
    return net_sum
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
            
assert(f(query: "a", base: [:] as [String : Int]) == 0)
