func f(d: [Int : Int]) -> [Int : Int] {
    var mutableDict = d
    let key1 = mutableDict.sorted { $0.key > $1.key }.first!.key
    let val1 = mutableDict.removeValue(forKey: key1)!
    let key2 = mutableDict.sorted { $0.key > $1.key }.first!.key
    let val2 = mutableDict.removeValue(forKey: key2)!
    return [key1: val1, key2: val2]
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
            
assert(f(d: [2 : 3, 17 : 3, 16 : 6, 18 : 6, 87 : 7]) == [87 : 7, 18 : 6])
