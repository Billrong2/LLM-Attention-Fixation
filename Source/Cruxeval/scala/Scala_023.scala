import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, chars : String) : String = {
        var result = text
        if (!chars.isEmpty) {
            result = result.reverse.dropWhile(c => chars.contains(c)).reverse
        } else {
            result = result.trim
        }
        if (result.isEmpty) {
            return "-"
        }
        return result
    }
    def main(args: Array[String]) = {
    assert(f(("new-medium-performing-application - XQuery 2.2"), ("0123456789-")).equals(("new-medium-performing-application - XQuery 2.")));
    }

}
