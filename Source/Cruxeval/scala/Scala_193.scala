import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : String = {
        val count = s.count(_ == ':')
        if (count > 1) {
            s.replaceFirst(":", "")
        } else {
            s
        }
    }
    def main(args: Array[String]) = {
    assert(f(("1::1")).equals(("1:1")));
    }

}
