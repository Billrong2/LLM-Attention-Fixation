import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, x : String) : String = {
        var count = 0
        var str = s
        while (str.startsWith(x) && count < s.length - x.length) {
            str = str.substring(x.length)
            count += x.length
        }
        return str
    }
    def main(args: Array[String]) = {
    assert(f(("If you want to live a happy life! Daniel"), ("Daniel")).equals(("If you want to live a happy life! Daniel")));
    }

}
