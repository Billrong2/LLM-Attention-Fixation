import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long]) : List[Long] = {
        var new_lst = List[Long]()
        var i = lst.length - 1
        for (_ <- lst.indices) {
            if (i % 2 == 0) {
                new_lst = new_lst :+ (-lst(i))
            } else {
                new_lst = new_lst :+ lst(i)
            }
            i -= 1
        }
        new_lst
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 7l.toLong, -1l.toLong, -3l.toLong))).equals((List[Long](-3l.toLong, 1l.toLong, 7l.toLong, -1l.toLong))));
    }

}
