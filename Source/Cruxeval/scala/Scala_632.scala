import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long]) : List[Long] = {
        var tempList = lst.toBuffer
        for (i <- tempList.indices.reverse) {
            for (j <- 0 until i) {
                if (tempList(j) > tempList(j + 1)) {
                    val temp = tempList(j)
                    tempList(j) = tempList(j + 1)
                    tempList(j + 1) = temp
                }
            }
        }
        tempList.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](63l.toLong, 0l.toLong, 1l.toLong, 5l.toLong, 9l.toLong, 87l.toLong, 0l.toLong, 7l.toLong, 25l.toLong, 4l.toLong))).equals((List[Long](0l.toLong, 0l.toLong, 1l.toLong, 4l.toLong, 5l.toLong, 7l.toLong, 9l.toLong, 25l.toLong, 63l.toLong, 87l.toLong))));
    }

}
