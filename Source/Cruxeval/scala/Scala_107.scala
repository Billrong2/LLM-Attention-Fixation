import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var result = new ListBuffer[Char]()
        for (i <- 0 until text.length) {
            if (!text(i).isLetterOrDigit) {
                return false.toString
            } else if (text(i).isLetterOrDigit) {
                result += text(i).toUpper
            } else {
                result += text(i)
            }
        }
        result.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("ua6hajq")).equals(("UA6HAJQ")));
    }

}
