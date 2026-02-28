/// 
func f(items: [(AnyHashable, AnyHashable)]) -> [[AnyHashable : AnyHashable]] {
    var result: [[AnyHashable: AnyHashable]] = []
    var items = items
    
    for item in items {
        var d = Dictionary(uniqueKeysWithValues: items).filter { $0.key != item.0 }
        result.append(d)
        items = Array(d)
    }
    
    return result
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
            
assert(f(items: [(1, "pos")]) == [[:] as [Int : Int]])
