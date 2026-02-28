import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, o : String) : String = {
        if (s.startsWith(o)) {
            return s
        }
        return o + f(s, o.reverse.tail)
    }
    def main(args: Array[String]) = {
    assert(f(("abba"), ("bab")).equals(("bababba")));
    }

}
