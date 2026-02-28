import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a_str : String, prefix : String) : String = {
        if (a_str.stripPrefix(prefix).contains(a_str)) a_str
        else prefix + a_str
    }
    def main(args: Array[String]) = {
    assert(f(("abc"), ("abcd")).equals(("abc")));
    }

}
