import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        var ls = text.toList
        ls = ls.updated(0, ls.last.toUpper).updated(ls.length - 1, ls.head.toUpper)
        ls.mkString("").capitalize == text.capitalize
    }
    def main(args: Array[String]) = {
    assert(f(("Josh")) == (false));
    }

}
