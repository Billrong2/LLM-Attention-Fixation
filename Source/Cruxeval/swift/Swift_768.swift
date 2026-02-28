import Foundation

func f(s: String, o: String) -> String {
    if s.hasPrefix(o) {
        return s
    }
    let reversedO = String(o.reversed())
    let startIndex = reversedO.index(reversedO.startIndex, offsetBy: 1)
    let endIndex = reversedO.endIndex
    let slicedO = String(reversedO[startIndex..<endIndex])
    return o + f(s: s, o: slicedO)
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
            
assert(f(s: "abba", o: "bab") == "bababba")
