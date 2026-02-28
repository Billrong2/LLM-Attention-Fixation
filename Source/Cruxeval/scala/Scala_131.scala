import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var a = text.length
        var count = 0L
        var t = text
        while (t.nonEmpty) {
            if (t.startsWith("a")) {
                count += t.indexOf(' ')
            } else {
                count += t.indexOf('\n')
            }
            if (t.indexOf('\n') == -1) {
              t = ""
            } else {
              t = t.slice(t.indexOf('\n') + 1, t.indexOf('\n') + 1 + a)
            }
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f(("a\nkgf\nasd\n")) == (1l));
    }

}
