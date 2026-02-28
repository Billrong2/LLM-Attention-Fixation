import Foundation

func f(a: String, b: String, n: Int) -> String {
    var result = b
    var m = b
    var mutableA = a
    for _ in 0..<n {
        if let range = mutableA.range(of: m) {
            mutableA = mutableA.replacingOccurrences(of: m, with: "")
            result = m
            m = b
        } else {
            m = ""
        }
    }
    return mutableA.components(separatedBy: b).joined(separator: "")
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
            
assert(f(a: "unrndqafi", b: "c", n: 2) == "unrndqafi")
