import scala.math._
import scala.collection.mutable._

object Problem {
    def rpartition(s: String, sep: Char): (String, String, String) = {
        val idx = s.lastIndexOf(sep)
        if (idx < 0) (s, "", "")
        else (s.substring(0, idx), sep.toString, s.substring(idx + 1, s.length))
    }

    def f(s : String) : String = {
        val (left, sep, right) = rpartition(s, '.')
        val newString = right + sep + left
        val (_, sep2, _) = rpartition(newString, '.')
        newString.replace(sep2, ", ")
    }
    def main(args: Array[String]) = {
    assert(f(("galgu")).equals((", g, a, l, g, u, ")));
    }

}
