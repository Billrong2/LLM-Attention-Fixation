import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String) : Long = {
        var upper = 0
        for (c <- string) {
            if (c.isUpper) {
                upper += 1
            }
        }
        upper * Array(2, 1)(upper % 2)
    }
    def main(args: Array[String]) = {
    assert(f(("PoIOarTvpoead")) == (8l));
    }

}
