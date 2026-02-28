import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, froms : String) : String = {
        var text1 = text.dropWhile(froms.contains(_))
        var text2 = text1.reverse.dropWhile(froms.contains(_)).reverse
        text2
    }
    def main(args: Array[String]) = {
    assert(f(("0 t 1cos "), ("st 0	\n  ")).equals(("1co")));
    }

}
