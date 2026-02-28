import scala.collection.mutable._
import scala.math._
object Problem {
    def f(nums: List[Long]): String = {
        val count = nums.length
        val score = Map(0L -> "F", 1L -> "E", 2L -> "D", 3L -> "C", 4L -> "B", 5L -> "A", 6L -> "")
        val result = new StringBuilder
        for (i <- 0 until count) {
            result.append(score.getOrElse(nums(i), ""))
        }
        result.toString
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](4l.toLong, 5l.toLong))).equals(("BA")));
    }

}
