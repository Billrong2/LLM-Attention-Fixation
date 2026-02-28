import scala.math._
import scala.collection.mutable._
object Problem {
    def f(x : String) : Boolean = {
        val n = x.length
        var i = 0
        while (i < n && x(i).isDigit) {
            i += 1
        }
        i == n
    }
    def main(args: Array[String]) = {
    assert(f(("1")) == (true));
    }

}
