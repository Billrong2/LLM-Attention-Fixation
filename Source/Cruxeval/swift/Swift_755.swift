import Foundation

func f(replace: String, text: String, hide: String) -> String {
    var tempReplace = replace
    var tempText = text
    while tempText.contains(hide) {
        tempReplace += "ax"
        tempText = tempText.replacingOccurrences(of: hide, with: tempReplace)
    }
    return tempText
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
            
assert(f(replace: "###", text: "ph>t#A#BiEcDefW#ON#iiNCU", hide: ".") == "ph>t#A#BiEcDefW#ON#iiNCU")
