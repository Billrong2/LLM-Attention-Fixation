import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, n : Long) : String = {
        if (s.length < n) {
            s
        } else {
            s.drop(n.toInt)
        }
    }
    def main(args: Array[String]) = {
    assert(f(("try."), (5l)).equals(("try.")));
    }

}
