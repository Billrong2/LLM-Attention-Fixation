import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : String, b : String) : Tuple2[String, String] = {
        if (a < b) {
            (b, a)
        } else {
            (a, b)
        }
    }
    def main(args: Array[String]) = {
    assert(f(("ml"), ("mv")).equals((("mv", "ml"))));
    }

}
