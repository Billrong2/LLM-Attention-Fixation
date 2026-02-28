/// 
func f(fruits: [String]) -> [String] {
    var modifiedFruits = fruits
    if modifiedFruits.last == modifiedFruits.first {
        return ["no"]
    } else {
        modifiedFruits.removeFirst()
        modifiedFruits.removeLast()
        modifiedFruits.removeFirst()
        modifiedFruits.removeLast()
        return modifiedFruits
    }
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
            
assert(f(fruits: ["apple", "apple", "pear", "banana", "pear", "orange", "orange"]) == ["pear", "banana", "pear"])
