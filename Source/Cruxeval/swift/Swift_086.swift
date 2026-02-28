extension Array: Error {}

func f(instagram: [String], imgur: [String], wins: Int) -> Result<String, [String]> {
    var photos = [instagram, imgur]
    if instagram == imgur {
        return .success("\(wins)")
    }
    if wins == 1 {
        return .failure(photos.popLast()!)
    } else {
        photos.reverse()
        return .failure(photos.popLast()!)
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
            
assert(f(instagram: ["sdfs", "drcr", "2e"], imgur: ["sdfs", "dr2c", "QWERTY"], wins: 0) == .failure(["sdfs", "drcr", "2e"]))
