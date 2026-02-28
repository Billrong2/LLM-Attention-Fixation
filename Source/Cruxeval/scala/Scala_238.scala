import scala.math._
import scala.collection.mutable._
object Problem {
    def f(ls : List[List[Long]], n : Long) : Any = {
        var answer : List[Long] = List()
        for (i <- ls) {
            if (i.head == n) {
                answer = i
            }
        }
        answer
    }
    def main(args: Array[String]) = {
    assert(f((List[List[Long]](List[Long](1l.toLong, 9l.toLong, 4l.toLong), List[Long](83l.toLong, 0l.toLong, 5l.toLong), List[Long](9l.toLong, 6l.toLong, 100l.toLong))), (1l)).equals(List[Long](1l.toLong, 9l.toLong, 4l.toLong)));
    }

}
