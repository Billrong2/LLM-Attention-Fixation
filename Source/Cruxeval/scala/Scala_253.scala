import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, pref : String) : String = {
        val length = pref.length()
        if (pref == text.substring(0, length)) {
            return text.substring(length)
        } else {
            return text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("kumwwfv"), ("k")).equals(("umwwfv")));
    }

}
