/// 
func f(n: Int, m: Int, num: Int) -> Int {
    var x_list = Array(n...m)
    var j = 0
    while true {
        j = (j + num) % x_list.count
        if x_list[j] % 2 == 0 {
            return x_list[j]
        }
    }
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
            
assert(f(n: 46, m: 48, num: 21) == 46)
