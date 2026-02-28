import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, suffix : String) : String = {
        if (text.endsWith(suffix)) {
            text.substring(0, text.length - suffix.length)
        } else {
            text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("zejrohaj"), ("owc")).equals(("zejrohaj")));
    }

}
