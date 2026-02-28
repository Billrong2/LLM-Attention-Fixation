/// 
func f(names: [String]) -> String {
    guard !names.isEmpty else { return "" }
    var smallest = names[0]
    for name in names[1...] {
        if name < smallest {
            smallest = name
        }
    }
    if let index = names.firstIndex(of: smallest) {
        var namesCopy = names
        namesCopy.remove(at: index)
        return namesCopy.joined()
    }
    return ""
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
            
assert(f(names: [] as [String]) == "")
