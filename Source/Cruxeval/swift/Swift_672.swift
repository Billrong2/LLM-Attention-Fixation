/// 
func f(text: String, position: Int, value: String) -> String {
    let length = text.count
    let lengthPlusTwo = length + 2
    var index = (position % lengthPlusTwo) - 1
    if index >= length || index < 0 {
        return text
    }
    var textArray = Array(text)
    textArray[index] = Character(value)
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
            
assert(f(text: "1zd", position: 0, value: "m") == "1zd")
