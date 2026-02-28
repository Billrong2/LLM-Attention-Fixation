import Foundation

func f(text: String, use: String) -> String {
    return text.replacingOccurrences(of: use, with: "", options: .regularExpression, range: nil)
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
            
assert(f(text: "Chris requires a ride to the airport on Friday.", use: "a") == "Chris requires  ride to the irport on Fridy.")
