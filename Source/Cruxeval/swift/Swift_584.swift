import Foundation

func f(txt: String) -> String {
    let zeros = String(repeating: "0", count: 20)
    return String(format: txt, arguments: [zeros])
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
            
assert(f(txt: "5123807309875480094949830") == "5123807309875480094949830")
