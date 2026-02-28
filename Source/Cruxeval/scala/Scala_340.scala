import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val uppercase_index = text.indexOf('A')
        if (uppercase_index >= 0) {
            return text.substring(0, uppercase_index) + text.substring(text.indexOf('a') + 1)
        } else {
            return text.sorted
        }
    }
    def main(args: Array[String]) = {
    assert(f(("E jIkx HtDpV G")).equals(("   DEGHIVjkptx")));
    }

}
