import Foundation

func f(s: String, ch: String) -> String {
    if !s.contains(ch) {
        return ""
    }
    
    var s = s.components(separatedBy: ch).dropFirst().joined(separator: ch).reversed()
    for _ in 0..<s.count {
        s = String(s).components(separatedBy: ch).dropFirst().joined(separator: ch).reversed()
    }
    
    return String(s)
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
            
assert(f(s: "shivajimonto6", ch: "6") == "")
