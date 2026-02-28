import Foundation

func f(sentence: String) -> String {
    if sentence.isEmpty {
        return ""
    }
    var sentence = sentence
    sentence = sentence.replacingOccurrences(of: "(", with: "")
    sentence = sentence.replacingOccurrences(of: ")", with: "")
    sentence = sentence.replacingOccurrences(of: " ", with: "")
    return sentence.prefix(1).uppercased() + sentence.dropFirst().lowercased()
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
            
assert(f(sentence: "(A (b B))") == "Abb")
