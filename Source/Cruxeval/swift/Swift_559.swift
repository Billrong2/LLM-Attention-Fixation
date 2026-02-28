import Foundation

func f(n: String) -> String {
    let firstChar = n.prefix(1)
    let rest = String(n.dropFirst()).replacingOccurrences(of: "-", with: "_")
    return firstChar + "." + rest
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
            
assert(f(n: "first-second-third") == "f.irst_second_third")
