import Foundation

func f(text: String, a: String, b: String) -> String {
    let text = text.replacingOccurrences(of: a, with: b)
    return text.replacingOccurrences(of: b, with: a)
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
            
assert(f(text: " vup a zwwo oihee amuwuuw! ", a: "a", b: "u") == " vap a zwwo oihee amawaaw! ")
