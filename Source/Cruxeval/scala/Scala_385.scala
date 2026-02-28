import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long]) : List[Long] = {
        var i = 0
        var new_list = List[Long]()
        while (i < lst.length) {
            if (lst(i) == lst.drop(i + 1).find(_ == lst(i)).getOrElse(0L)) {
                new_list = new_list :+ lst(i)
                if (new_list.length == 3) {
                    return new_list
                }
            }
            i += 1
        }
        new_list
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](0l.toLong, 2l.toLong, 1l.toLong, 2l.toLong, 6l.toLong, 2l.toLong, 6l.toLong, 3l.toLong, 0l.toLong))).equals((List[Long](0l.toLong, 2l.toLong, 2l.toLong))));
    }

}
