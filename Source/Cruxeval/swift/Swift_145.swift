func f(price: Double, product: String) -> Double {
    var price = price
    var inventory = ["olives", "key", "orange"]
    
    if !inventory.contains(product) {
        return price
    } else {
        price *= 0.85
        if let index = inventory.firstIndex(of: product) {
            inventory.remove(at: index)
        }
    }
    
    return price
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
            
assert(f(price: 8.5, product: "grapes") == 8.5)
