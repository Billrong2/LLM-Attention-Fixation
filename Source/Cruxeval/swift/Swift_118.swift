import Foundation

func f(text: String, chars: String) -> String {
    var text = text
    let numApplies = 2
    var extraChars = ""
    
    for _ in 0..<numApplies {
        extraChars += chars
        text = text.replacingOccurrences(of: extraChars, with: "")
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
            
assert(f(text: "zbzquiuqnmfkx", chars: "mk") == "zbzquiuqnmfkx")
