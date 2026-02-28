import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String): Int = {
        val upperCaseText = text.toUpperCase
        var countUpper = 0
        for (char <- upperCaseText) {
            if (char.isUpper) {
                countUpper += 1
            } else {
                return 0  // Return 0 instead of "no"
            }
        }
        countUpper / 2
    }
    def main(args: Array[String]) = {
    assert(f(("ax")) == (1l));
    }

}
