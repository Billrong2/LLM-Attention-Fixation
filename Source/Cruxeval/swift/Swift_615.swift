/// 
func f(in_list: [Int], num: Int) -> Int {
var mutableList = in_list
mutableList.append(num)
return mutableList.firstIndex(of: mutableList.dropLast().max()!)!
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
            
assert(f(in_list: [-1, 12, -6, -2], num: -1) == 1)
