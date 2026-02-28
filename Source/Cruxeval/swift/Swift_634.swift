/// 
func f(input_string: String) -> String {
    var table = ["a": "i", "i": "o", "o": "u", "e": "a"]
    var inputString = input_string
    
    while inputString.contains("a") || inputString.contains("A") {
        inputString = inputString.map { table[String($0).lowercased()] ?? String($0) }.joined()
    }
    
    return inputString
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
            
assert(f(input_string: "biec") == "biec")
