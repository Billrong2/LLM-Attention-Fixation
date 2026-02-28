import Foundation

func f(string: String) -> String {
    let count = string.filter { $0 == ":" }.count
    let range = string.range(of: ":")!
    let substring = string.replacingOccurrences(of: ":", with: "", options: .backwards, range: range)
    return String(substring)
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
            
assert(f(string: "1::1") == "1:1")
