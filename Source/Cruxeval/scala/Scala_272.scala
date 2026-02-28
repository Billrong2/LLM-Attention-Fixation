import scala.math._
import scala.collection.mutable._

object Problem {
    def f(base_list: List[Long], nums: List[Long]): List[Long] = {
        val combinedList = base_list ++ nums
        val res = combinedList.toBuffer
        for (i <- -nums.length until 0) {
            res.append(res(i + res.length))
        }
        res.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](9l.toLong, 7l.toLong, 5l.toLong, 3l.toLong, 1l.toLong)), (List[Long](2l.toLong, 4l.toLong, 6l.toLong, 8l.toLong, 0l.toLong))).equals((List[Long](9l.toLong, 7l.toLong, 5l.toLong, 3l.toLong, 1l.toLong, 2l.toLong, 4l.toLong, 6l.toLong, 8l.toLong, 0l.toLong, 2l.toLong, 6l.toLong, 0l.toLong, 6l.toLong, 6l.toLong))));
    }

}
