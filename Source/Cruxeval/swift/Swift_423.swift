/// 
func f(selfie: [Int]) -> [Int] {
    var selfie = selfie
    let lo = selfie.count
    for i in stride(from: lo-1, through: 0, by: -1) {
        if selfie[i] == selfie[0] {
            selfie.remove(at: lo-1)
        }
    }
    return selfie
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
            
assert(f(selfie: [4, 2, 5, 1, 3, 2, 6]) == [4, 2, 5, 1, 3, 2])
