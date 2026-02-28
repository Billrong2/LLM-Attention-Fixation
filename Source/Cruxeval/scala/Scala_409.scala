import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : String = {
        var result = text
        if (text.nonEmpty) {
            result = text.stripPrefix(char)
            result = result.stripPrefix(result.charAt(result.length - 1).toString)
            result = result.init + result.last.toUpper
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("querist"), ("u")).equals(("querisT")));
    }

}
