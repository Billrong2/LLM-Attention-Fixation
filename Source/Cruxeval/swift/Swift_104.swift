/// 
func f(text: String) -> [String : Int] {
    var dictionary = [String: Int]()
    for char in text {
        dictionary[String(char)] = (dictionary[String(char)] ?? 0) + 1
    }
    for key in dictionary.keys {
        if let count = dictionary[key], count > 1 {
            dictionary[key] = 1
        }
    }
    return dictionary
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
            
assert(f(text: "a") == ["a" : 1])
