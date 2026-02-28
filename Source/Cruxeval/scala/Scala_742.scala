import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String): Boolean = {
        var b = true
        var continueLoop = true
        for (x <- text if continueLoop) {
            if (Character.isDigit(x)) {
                b = true
            } else {
                b = false
                continueLoop = false
            }
        }
        b
    }
    def main(args: Array[String]) = {
    assert(f(("-1-3")) == (false));
    }

}
