import scala.math._
import scala.collection.mutable._
object Problem {
    def f(prefix : String, text : String) : String = {
        if (text.startsWith(prefix)) {
            text
        } else {
            prefix + text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("mjs"), ("mjqwmjsqjwisojqwiso")).equals(("mjsmjqwmjsqjwisojqwiso")));
    }

}
