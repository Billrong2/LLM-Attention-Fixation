import Foundation

func f(names: [String], excluded: String) -> [String] {
    var newNames = names
    for i in 0..<newNames.count {
        if newNames[i].contains(excluded) {
            newNames[i] = newNames[i].replacingOccurrences(of: excluded, with: "")
        }
    }
    return newNames
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
            
assert(f(names: ["avc  a .d e"], excluded: "") == ["avc  a .d e"])
