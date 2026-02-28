import Foundation

func f(s: String, sep: String) -> String {
    let s = s + sep
    if let range = s.range(of: sep, options: .backwards) {
        return String(s[..<range.lowerBound])
    }
    return s
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
            
assert(f(s: "234dsfssdfs333324314", sep: "s") == "234dsfssdfs333324314")
