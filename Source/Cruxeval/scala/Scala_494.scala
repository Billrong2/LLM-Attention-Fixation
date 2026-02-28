import scala.collection.mutable._
import scala.math._
object Problem {
    def f(num: String, l: Long): String = {
        var t = ""
        var length = l
        while (length > num.length) {
            t += '0'
            length -= 1
        }
        t + num
    }
    def main(args: Array[String]) = {
    assert(f(("1"), (3l)).equals(("001")));
    }

}
