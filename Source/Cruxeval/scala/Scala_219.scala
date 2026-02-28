import scala.collection.mutable._
import scala.math._
object Problem {
    def f(s1: String, s2: String): Boolean = {
        var modifiedS1 = s1
        for (k <- 0 until s2.length + s1.length) {
            modifiedS1 += modifiedS1(0)
            if (modifiedS1.indexOf(s2) >= 0) {
                return true
            }
        }
        false
    }
    def main(args: Array[String]) = {
    assert(f(("Hello"), (")")) == (false));
    }

}
