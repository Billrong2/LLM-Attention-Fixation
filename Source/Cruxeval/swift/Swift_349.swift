func f(dictionary: [String : Int]) -> [String : Int] {
    var dictionary = dictionary
    dictionary["1049"] = 55
    if let (key, value) = dictionary.popFirst() {
        dictionary[key] = value
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
            
assert(f(dictionary: ["noeohqhk" : 623]) == ["noeohqhk" : 623, "1049" : 55])
