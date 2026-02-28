import scala.math._
import scala.collection.mutable._
object Problem {
    def f(lst : List[Long]) : List[Long] = {
        lst.patch(1, lst.slice(1, 4).reverse, 3)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong))).equals((List[Long](1l.toLong, 3l.toLong, 2l.toLong))));
    }

}
