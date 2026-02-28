import Foundation

func f(values: String, text: String, markers: String) -> String {
    return text.trimmingCharacters(in: NSCharacterSet(charactersIn: values + markers) as CharacterSet)
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
            
assert(f(values: "2Pn", text: "yCxpg2C2Pny2", markers: "") == "yCxpg2C2Pny")
