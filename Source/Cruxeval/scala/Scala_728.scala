import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var result = new ListBuffer[Char]()
        for (i <- 0 until text.length) {
            val ch = text(i)
            if (ch == ch.toLower) {
                // do nothing
            }
            else {
                if (text.length - 1 - i < text.lastIndexOf(ch.toLower)) {
                    result += ch
                }
            }
        }
        result.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("ru")).equals(("")));
    }

}
