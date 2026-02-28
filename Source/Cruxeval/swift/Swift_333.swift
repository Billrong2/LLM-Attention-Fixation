/// 
func f(places: [Int], lazy: [Int]) -> Int {
    var sortedPlaces = places.sorted()
    for l in lazy {
        if let index = sortedPlaces.firstIndex(of: l) {
            sortedPlaces.remove(at: index)
        }
    }
    
    if sortedPlaces.count == 1 {
        return 1
    }
    
    for i in 0..<sortedPlaces.count {
        if !sortedPlaces.contains(sortedPlaces[i] + 1) {
            return i + 1
        }
    }
    
    return sortedPlaces.count
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
            
assert(f(places: [375, 564, 857, 90, 728, 92], lazy: [728]) == 1)
