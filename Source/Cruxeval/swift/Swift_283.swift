/// 
func f(dictionary: [String : Int], key: String) -> String {
    var updatedDictionary = dictionary
    updatedDictionary.removeValue(forKey: key)
    if let minKey = updatedDictionary.keys.min(), minKey == key {
        return updatedDictionary.keys.first ?? ""
    }
    return key
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
            
assert(f(dictionary: ["Iron Man" : 4, "Captain America" : 3, "Black Panther" : 0, "Thor" : 1, "Ant-Man" : 6], key: "Iron Man") == "Iron Man")
