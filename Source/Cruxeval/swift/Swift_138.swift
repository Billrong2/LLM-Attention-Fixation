func f(text: String, chars: String) -> String {
    var textArray = Array(text)
    let listchars = Array(chars)
    let first = listchars[0]
    
    for i in 1..<listchars.count {
        if let index = textArray.firstIndex(of: listchars[i]) {
            textArray[index] = listchars[i]
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
            
assert(f(text: "tflb omn rtt", chars: "m") == "tflb omn rtt")
