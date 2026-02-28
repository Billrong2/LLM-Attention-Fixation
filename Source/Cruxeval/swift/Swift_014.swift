import Foundation

func f(s: String) -> String {
    var arr = Array(s.trimmingCharacters(in: .whitespaces))
    arr.reverse()
    return String(arr)
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
            
assert(f(s: "   OOP   ") == "POO")
