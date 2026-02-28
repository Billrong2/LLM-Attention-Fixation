import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, ch : String) : String = {
        var sl = s
        if (s.contains(ch)) {
            sl = s.dropWhile(_ == ch.head)
            if (sl.length == 0) {
                sl = sl + "!?"
            }
        } else {
            return "no"
        }
        sl
    }
    def main(args: Array[String]) = {
    assert(f(("@@@ff"), ("@")).equals(("ff")));
    }

}
