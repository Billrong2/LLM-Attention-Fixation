import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val count = text.count(_ == text(0))
        var ls = text.toList
        for (_ <- 0 until count) {
            ls = ls.tail
        }
        ls.mkString
    }
    def main(args: Array[String]) = {
    assert(f((";,,,?")).equals((",,,?")));
    }

}
