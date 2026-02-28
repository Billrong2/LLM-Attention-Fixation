import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : Long = {
        var count = 0
        for (c <- s) {
            if (s.lastIndexWhere(_ == c) != s.indexOf(c)) {
                count += 1
            }
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f(("abca dea ead")) == (10l));
    }

}
