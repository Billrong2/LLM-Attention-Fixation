/// 
func f(marks: [String : Int]) -> (Int, Int) {
    var highest = 0
    var lowest = 100
    for value in marks.values {
        if value > highest {
            highest = value
        }
        if value < lowest {
            lowest = value
        }
    }
    return (highest, lowest)
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
            
assert(f(marks: ["x" : 67, "v" : 89, "" : 4, "alij" : 11, "kgfsd" : 72, "yafby" : 83]) == (89, 4))
