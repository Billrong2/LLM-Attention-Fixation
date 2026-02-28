/// 
func f(messages: [[String]]) -> String {
    let phone_code = ["+", "3", "5", "3"]
    var result = [String]()
    for message in messages {
        var newMessage = message
        newMessage.append(contentsOf: phone_code)
        result.append(newMessage.joined(separator: ";"))
    }
    return result.joined(separator: ". ")
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
            
assert(f(messages: [["Marie", "Nelson", "Oscar"]]) == "Marie;Nelson;Oscar;+;3;5;3")
