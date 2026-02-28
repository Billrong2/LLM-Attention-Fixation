import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, c : String) : String = {
        var ls = text.toList
        if (!text.contains(c)) {
            throw new IllegalArgumentException(s"Text has no $c")
        }
        ls = ls.patch(text.lastIndexOf(c), Nil, 1)
        ls.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("uufhl"), ("l")).equals(("uufh")));
    }

}
