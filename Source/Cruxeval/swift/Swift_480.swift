import Foundation

func f(s: String, c1: String, c2: String) -> String {
    if s.isEmpty {
        return s
    }
    var ls = s.components(separatedBy: c1)
    for (index, item) in ls.enumerated() {
        if item.contains(c1) {
            if let range = item.range(of: c1) {
                ls[index] = item.replacingCharacters(in: range, with: c2)
            }
        }
    }
    return ls.joined(separator: c1)
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
            
assert(f(s: "", c1: "mi", c2: "siast") == "")
