import Foundation

func f(s: String) -> String {
    if let range = s.range(of: "ar", options: .backwards) {
        let before = s[..<range.lowerBound]
        let match = s[range]
        let after = s[range.upperBound...]
        return "\(before) \(match) \(after)"
    } else {
        return s
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
            
assert(f(s: "xxxarmmarxx") == "xxxarmm ar xx")
