import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String, value: String): String = {
        var new_text = text.toList
        var length = 0
        try {
            new_text = new_text ++ value.toList
            length = new_text.length
        } catch {
            case _: IndexOutOfBoundsException => length = 0
        }
        "[" + length.toString + "]"
    }
    def main(args: Array[String]) = {
    assert(f(("abv"), ("a")).equals(("[4]")));
    }

}
