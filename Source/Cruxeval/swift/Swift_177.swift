func f(text: String) -> String {
    var textArray = Array(text)
    for i in 0..<textArray.count {
        if i % 2 == 1 {
            let char = String(textArray[i])
            textArray[i] = char.uppercased() == char ? char.lowercased().first! : char.uppercased().first!
        }
    }
    return String(textArray)
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
            
assert(f(text: "Hey DUdE THis $nd^ &*&this@#") == "HEy Dude tHIs $Nd^ &*&tHiS@#")
