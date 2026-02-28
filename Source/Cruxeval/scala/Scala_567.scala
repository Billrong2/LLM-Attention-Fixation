import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, n : Long) : List[String] = {
        var ls = s.split(' ').toList
        var out = List.empty[String]
        while (ls.length >= n) {
            out = ls.slice(ls.length - n.toInt, ls.length) ::: out
            ls = ls.slice(0, ls.length - n.toInt)
        }
        ls ::: List(out.mkString("_"))
    }
    def main(args: Array[String]) = {
    assert(f(("one two three four five"), (3l)).equals((List[String]("one", "two", "three_four_five"))));
    }

}
