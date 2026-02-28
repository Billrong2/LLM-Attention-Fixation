/// 
func f(chemicals: [String], num: Int) -> [String] {
    var fish = Array(chemicals[1...])
    var chemicalsCopy = chemicals
    chemicalsCopy.reverse()
    
    for _ in 0..<num {
        fish.append(chemicalsCopy.remove(at: 1))
    }
    
    chemicalsCopy.reverse()
    return chemicalsCopy
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
            
assert(f(chemicals: ["lsi", "s", "t", "t", "d"], num: 0) == ["lsi", "s", "t", "t", "d"])
