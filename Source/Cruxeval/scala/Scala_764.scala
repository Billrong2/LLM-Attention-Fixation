import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String, old : String, replacement : String) : String = {
        var text2 = text.replace(old, replacement)
        var old2 = old.reverse
        while (text2.contains(old2)) {
            text2 = text2.replace(old2, replacement)
        }
        text2
    }
    def main(args: Array[String]) = {
    assert(f(("some test string"), ("some"), ("any")).equals(("any test string")));
    }

}
