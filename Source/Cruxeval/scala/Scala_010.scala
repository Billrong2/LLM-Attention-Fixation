import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var new_text = ""
        for (ch <- text.toLowerCase.trim) {
            if (ch.isDigit || ch == 'ä' || ch == 'ö' || ch == 'ü' || ch == 'ï') {
                new_text += ch
            }
        }
        new_text
    }
    def main(args: Array[String]) = {
    assert(f(("")).equals(("")));
    }

}
