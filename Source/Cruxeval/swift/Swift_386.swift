func f(concat: String, di: [String : String]) -> String {
    var updatedDict = di
    let count = updatedDict.count
    for i in 0..<count {
        if let value = updatedDict[String(i)] {
            for char in concat {
                if value.contains(char) {
                    updatedDict.removeValue(forKey: String(i))
                    break
                }
            }
        }
    }
    return "Done!"
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
            
assert(f(concat: "mid", di: ["0" : "q", "1" : "f", "2" : "w", "3" : "i"]) == "Done!")
