/// 
func f(text: String, letter: String) -> Int {
    var counts: [Character: Int] = [:]
    for char in text {
        if counts[char] == nil {
            counts[char] = 1
        } else {
            counts[char]! += 1
        }
    }
    return counts[Character(letter)] ?? 0
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
            
assert(f(text: "za1fd1as8f7afasdfam97adfa", letter: "7") == 2)
