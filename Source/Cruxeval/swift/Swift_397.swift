extension Int: Error {}

func f(ls: [Result<String, Int>]) -> [AnyHashable : Int] {
    var dict = [AnyHashable : Int]()
    for element in ls {
        switch element {
        case .success(let value):
            dict[value] = 0
        case .failure:
            break
        }
    }
    return dict
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
            
assert(f(ls: [.success("x"), .success("u"), .success("w"), .success("j"), .success("3"), .success("6")]) == ["x" : 0, "u" : 0, "w" : 0, "j" : 0, "3" : 0, "6" : 0])
