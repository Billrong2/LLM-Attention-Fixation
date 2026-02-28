import scala.math._
import scala.collection.mutable._
object Problem {
    def f(list : List[Long]) : List[Long] = {
        var new_list = list
        while (new_list.length > 1) {
            new_list = new_list.dropRight(1)
            for (i <- 0 until new_list.length) {
                new_list = new_list.take(i) ++ new_list.drop(i + 1)
            }
        }
        new_list = list
        if (new_list.nonEmpty) {
            new_list = new_list.drop(1)
        }
        new_list
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]())).equals((List[Long]())));
    }

}
