import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, n : Long) : String = {
        if (text.length <= 2) {
            return text
        }
        val leading_chars = text.head.toString * (n.toInt - text.length + 1)
        return leading_chars + text.tail.init + text.last
    }
    def main(args: Array[String]) = {
    assert(f(("g"), (15l)).equals(("g")));
    }

}
