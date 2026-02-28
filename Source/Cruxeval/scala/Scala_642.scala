import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var i = 0
        while (i < text.length && text(i).isWhitespace) {
            i += 1
        }
        if (i == text.length) {
            return "space"
        } else {
            return "no"
        }
    }
    def main(args: Array[String]) = {
    assert(f(("     ")).equals(("space")));
    }

}
