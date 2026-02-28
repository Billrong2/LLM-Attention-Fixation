import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String): String = {
        var ls = text.toList
        var shouldBreak = false
        for (x <- (ls.length - 1).until(-1, -1) if !shouldBreak) {
            if (ls.length <= 1) shouldBreak = true
            if (!"zyxwvutsrqponmlkjihgfedcba".contains(ls(x))) ls = ls.filterNot(_ == ls(x))
        }
        ls.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("qq")).equals(("qq")));
    }

}
