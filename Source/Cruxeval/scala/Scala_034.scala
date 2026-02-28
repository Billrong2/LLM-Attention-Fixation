import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long], odd1 : Long, odd2 : Long) : List[Long] = {
        var result = nums
        while (result.contains(odd1)) {
            result = result.filter(_ != odd1)
        }
        while (result.contains(odd2)) {
            result = result.filter(_ != odd2)
        }
        return result
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 7l.toLong, 7l.toLong, 6l.toLong, 8l.toLong, 4l.toLong, 1l.toLong, 2l.toLong, 3l.toLong, 5l.toLong, 1l.toLong, 3l.toLong, 21l.toLong, 1l.toLong, 3l.toLong)), (3l), (1l)).equals((List[Long](2l.toLong, 7l.toLong, 7l.toLong, 6l.toLong, 8l.toLong, 4l.toLong, 2l.toLong, 5l.toLong, 21l.toLong))));
    }

}
