import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String, chars : String) : String = {
        var new_text = text
        var shouldBreak = false
        while (new_text.length > 0 && text.length > 0 && !shouldBreak) {
            if (chars.contains(new_text.charAt(0))) {
                new_text = new_text.substring(1)
            } else {
                shouldBreak = true
            }
        }
        new_text
    }
    def main(args: Array[String]) = {
    assert(f(("asfdellos"), ("Ta")).equals(("sfdellos")));
    }

}
