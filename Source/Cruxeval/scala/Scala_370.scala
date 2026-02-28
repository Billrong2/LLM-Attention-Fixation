import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        for (char <- text) {
            if (!char.isWhitespace) {
                return false
            }
        }
        true
    }
    def main(args: Array[String]) = {
    assert(f(("     i")) == (false));
    }

}
