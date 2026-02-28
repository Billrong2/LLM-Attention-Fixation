import Foundation

func f(line: String, equalityMap: [(String, String)]) -> String {
    var rs = [Character: Character]()
    for (k, v) in equalityMap {
        if let key = k.first, let value = v.first {
            rs[key] = value
        }
    }
    
    var translatedLine = ""
    for char in line {
        if let translatedChar = rs[char] {
            translatedLine.append(translatedChar)
        } else {
            translatedLine.append(char)
        }
    }
    
    return translatedLine
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
            
assert(f(line: "abab", equalityMap: [("a", "b"), ("b", "a")]) == "baba")
