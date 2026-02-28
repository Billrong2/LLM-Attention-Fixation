/// 
func f(graph: [String : [String : String]]) -> [String : [String : String]] {
    var newGraph: [String: [String: String]] = [:]
    
    for (key, value) in graph {
        newGraph[key] = [:]
        for subkey in value.keys {
            newGraph[key]?[subkey] = ""
        }
    }
    
    return newGraph
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
            
assert(f(graph: [:] as [String : [String : String]]) == [:] as [String : [String : String]])
