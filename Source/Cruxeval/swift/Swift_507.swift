import Foundation

func f(text: String, search: String) -> Int {
    let result = text.lowercased()
    return result.range(of: search.lowercased())?.lowerBound.utf16Offset(in: result) ?? -1
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
            
assert(f(text: "car hat", search: "car") == 0)
