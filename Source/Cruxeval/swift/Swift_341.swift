/// 
func f(cart: [Int : Int]) -> [Int : Int] {
    var mutableCart = cart
    while mutableCart.count > 5 {
        mutableCart.removeValue(forKey: mutableCart.keys.first!)
    }
    return mutableCart
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
            
assert(f(cart: [:] as [Int : Int]) == [:] as [Int : Int])
