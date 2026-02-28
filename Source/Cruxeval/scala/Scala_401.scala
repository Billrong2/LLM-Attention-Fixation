import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, suffix : String) : String = {
        if (suffix.nonEmpty && text.endsWith(suffix)) {
            return text.substring(0, text.length - suffix.length)
        }
        text
    }
    def main(args: Array[String]) = {
    assert(f(("mathematics"), ("example")).equals(("mathematics")));
    }

}
