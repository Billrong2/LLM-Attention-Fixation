import Foundation

func f(s: String, tab: Int) -> String {
    return s.replacingOccurrences(of: "\t", with: String(repeating: " ", count: tab))
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
            
assert(f(s: "Join us in Hungary", tab: 4) == "Join us in Hungary")
