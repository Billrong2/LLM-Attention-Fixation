import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, comparison : String) : Long = {
        val length = comparison.length
        if (length <= text.length) {
            for (i <- 0 until length) {
                if (comparison.charAt(length - i - 1) != text.charAt(text.length - i - 1)) {
                    return i
                }
            }
        }
        return length
    }
    def main(args: Array[String]) = {
    assert(f(("managed"), ("")) == (0l));
    }

}
