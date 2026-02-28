import scala.collection.mutable._
import scala.math._
object Problem {
    def f(s1: String, s2: String): String = {
        var result = s2
        if (s2.endsWith(s1)) {
            result = s2.substring(0, s2.length - s1.length)
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("he"), ("hello")).equals(("hello")));
    }

}
