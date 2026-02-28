import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, length : Long) : String = {
        var len = if (length < 0) -length else length
        var output = ""
        for (idx <- 0 until len.toInt) {
            if (text.charAt(idx % text.length) != ' ') {
                output += text.charAt(idx % text.length)
            } else {
                return output
            }
        }
        output
    }
    def main(args: Array[String]) = {
    assert(f(("I got 1 and 0."), (5l)).equals(("I")));
    }

}
