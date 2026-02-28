import scala.math._
import scala.collection.mutable._
object Problem {
    def f(nums : List[Long]) : List[Tuple2[Long, Long]] = {
        var output: ListBuffer[(Long, Long)] = ListBuffer()
        for (n <- nums) {
            output += ((nums.count(_ == n), n))
        }
        output = output.sortWith((a, b) => a._1 > b._1)
        output.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 1l.toLong, 3l.toLong, 1l.toLong, 3l.toLong, 1l.toLong))).equals((List[Tuple2[Long, Long]]((4l, 1l), (4l, 1l), (4l, 1l), (4l, 1l), (2l, 3l), (2l, 3l)))));
    }

}
