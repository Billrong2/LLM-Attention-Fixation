/// 
func f(text: String, char1: String, char2: String) -> String {
    var t1a: [Character] = []
    var t2a: [Character] = []
    
    for i in 0..<char1.count {
        t1a.append(char1[char1.index(char1.startIndex, offsetBy: i)])
        t2a.append(char2[char2.index(char2.startIndex, offsetBy: i)])
    }
    
    var map = [Character: Character]()
    for (key, value) in zip(t1a, t2a) {
        map[key] = value
    }
    
    var translatedText = ""
    for char in text {
        if let translatedChar = map[char] {
            translatedText.append(translatedChar)
        } else {
            translatedText.append(char)
        }
    }
    
    return translatedText
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
            
assert(f(text: "ewriyat emf rwto segya", char1: "tey", char2: "dgo") == "gwrioad gmf rwdo sggoa")
