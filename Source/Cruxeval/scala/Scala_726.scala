import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Tuple2[Long, Long] = {
        var ws = 0l
        for (s <- text) {
            if (s.isWhitespace) {
                ws += 1
            }
        }
        (ws, text.length)
    }
    def main(args: Array[String]) = {
    assert(f(("jcle oq wsnibktxpiozyxmopqkfnrfjds")).equals(((2l, 34l))));
    }

}
