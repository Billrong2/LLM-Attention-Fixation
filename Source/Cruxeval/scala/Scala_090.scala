import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[List[Long]]) : List[List[Long]] = {
        var return_arr = ArrayBuffer.empty[List[Long]]
        for (a <- array) {
            return_arr += a.toList
        }
        return return_arr.toList
    }
    def main(args: Array[String]) = {
    assert(f((List[List[Long]](List[Long](1l.toLong, 2l.toLong, 3l.toLong), List[Long](), List[Long](1l.toLong, 2l.toLong, 3l.toLong)))).equals((List[List[Long]](List[Long](1l.toLong, 2l.toLong, 3l.toLong), List[Long](), List[Long](1l.toLong, 2l.toLong, 3l.toLong)))));
    }

}
