import Foundation

func f(text: String, old: String, new: String) -> String {
    var text = text
    
    if old.count > 3 {
        return text
    }
    
    if text.contains(old) && !text.contains(" ") {
        return text.replacingOccurrences(of: old, with: String(repeating: new, count: old.count))
    }
    
    while text.range(of: old) != nil {
        text = text.replacingOccurrences(of: old, with: new)
    }
    
    return text
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
            
assert(f(text: "avacado", old: "va", new: "-") == "a--cado")
