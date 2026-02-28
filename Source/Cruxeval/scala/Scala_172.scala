import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[Long]) : List[Long] = {
        array.filter(_ >= 0)
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]())).equals((List[Long]())));
    }

}
