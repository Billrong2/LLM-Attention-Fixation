/// 
func f(playlist: [String : [String]], liker_name: String, song_index: String) -> [String : [String]] {
    var updatedPlaylist = playlist
    updatedPlaylist[liker_name, default: []].append(song_index)
    return updatedPlaylist
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
            
assert(f(playlist: ["aki" : ["1", "5"]], liker_name: "aki", song_index: "2") == ["aki" : ["1", "5", "2"]])
