/// 
func f(text: String) -> String {
    let arr = text.split(separator: " ")
    var result = [String]()
    for item in arr {
        if item.hasSuffix("day") {
            result.append(item + "y")
        } else {
            result.append(item + "day")
        }
    }
    return result.joined(separator: " ")
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
            
assert(f(text: "nwv mef ofme bdryl") == "nwvday mefday ofmeday bdrylday")
