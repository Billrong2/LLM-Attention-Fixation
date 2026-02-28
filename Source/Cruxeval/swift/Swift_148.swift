func f(forest: String, animal: String) -> String {
    guard let index = forest.firstIndex(of: Character(animal)) else {
        return forest
    }
    
    var result = Array(forest)
    var currentIndex = forest.distance(from: forest.startIndex, to: index)
    
    while currentIndex < forest.count - 1 {
        result[currentIndex] = result[currentIndex + 1]
        currentIndex += 1
    }
    
    if currentIndex == forest.count - 1 {
        result[currentIndex] = "-"
    }
    
    return String(result)
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
            
assert(f(forest: "2imo 12 tfiqr.", animal: "m") == "2io 12 tfiqr.-")
