import Foundation

func f(challenge: String) -> String {
    return challenge.lowercased().replacingOccurrences(of: "l", with: ",")
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
            
assert(f(challenge: "czywZ") == "czywz")
