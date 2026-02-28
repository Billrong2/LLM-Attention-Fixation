import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        if (text.length() == 0) {
            return ""
        }
        val lowerText = text.toLowerCase()
        lowerText.charAt(0).toUpper + lowerText.substring(1)
    }
    def main(args: Array[String]) = {
    assert(f(("xzd")).equals(("Xzd")));
    }

}
