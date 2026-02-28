/// 
func f(c: [AnyHashable : AnyHashable], index: AnyHashable, value: AnyHashable) -> [AnyHashable : AnyHashable] {
    var c = c
    c[index] = value
    if let numericValue = value as? Int, numericValue >= 3 {
        c.updateValue("xcrWt", forKey: "message")
    } else {
        c.removeValue(forKey: "message")
    }
    return c
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
            
assert(f(c: [1 : 2, 3 : 4, 5 : 6, "message" : "qrTHo"], index: 8, value: 2) == [1 : 2, 3 : 4, 5 : 6, 8 : 2])
