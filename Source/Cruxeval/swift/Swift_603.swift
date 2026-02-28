func f(sentences: String) -> String {
    let sentenceArray = sentences.split(separator: ".")
    if sentenceArray.allSatisfy({ $0.allSatisfy { $0.isNumber } }) {
        return "oscillating"
    } else {
        return "not oscillating"
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
            
assert(f(sentences: "not numbers") == "not oscillating")
