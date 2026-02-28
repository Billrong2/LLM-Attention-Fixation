import scala.math._
import scala.collection.mutable._
object Problem {
    def f(n : Long, array : List[Long]) : List[List[Long]] = {
        var finalList = ListBuffer(array.toList)
        for (i <- 1 to n.toInt) {
            val arr = array.toList ::: finalList.last
            finalList += arr
        }
        finalList.toList
    }
    def main(args: Array[String]) = {
    assert(f((1l), (List[Long](1l.toLong, 2l.toLong, 3l.toLong))).equals((List[List[Long]](List[Long](1l.toLong, 2l.toLong, 3l.toLong), List[Long](1l.toLong, 2l.toLong, 3l.toLong, 1l.toLong, 2l.toLong, 3l.toLong)))));
    }

}
