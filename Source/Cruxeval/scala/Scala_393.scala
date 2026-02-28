import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val ls = text.reverse
        var text2 = ""
        for (i <- Range(ls.length - 3, 0, -3)) {
            text2 += ls.slice(i, i + 3).mkString("---") + "---"
        }
        text2.dropRight(3)
    }
    def main(args: Array[String]) = {
    assert(f(("scala")).equals(("a---c---s")));
    }

}
