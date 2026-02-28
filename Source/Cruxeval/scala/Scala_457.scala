import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Long] = {
        var nums_mutable = nums.toBuffer
        var count = nums.indices.toBuffer
        for (i <- nums.indices) {
            nums_mutable.remove(nums_mutable.size - 1)
            if (count.size > 0) {
                count.remove(0)
            }
        }
        nums_mutable.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](3l.toLong, 1l.toLong, 7l.toLong, 5l.toLong, 6l.toLong))).equals((List[Long]())));
    }

}
