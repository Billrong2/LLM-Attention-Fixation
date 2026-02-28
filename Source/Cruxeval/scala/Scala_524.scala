import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dict0 : Map[Long,Long]) : Map[Long,Long] = {
        var newMap = dict0.clone()
        val sortedKeys = newMap.keys.toList.sorted
        for (i <- 0 until sortedKeys.length - 1) {
            newMap += (sortedKeys(i) -> i)
        }
        newMap
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long](2l -> 5l, 4l -> 1l, 3l -> 5l, 1l -> 3l, 5l -> 1l))).equals((Map[Long,Long](2l -> 1l, 4l -> 3l, 3l -> 2l, 1l -> 0l, 5l -> 1l))));
    }

}
