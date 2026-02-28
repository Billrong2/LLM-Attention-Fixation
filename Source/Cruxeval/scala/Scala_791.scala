import scala.math._
import scala.collection.mutable._
object Problem {
    def f(integer : Long, n : Long) : String = {
        var i = 1
        var text = integer.toString()
        while (i + text.length < n) {
            i += text.length
        }
        text.reverse.padTo(i + text.length, '0').reverse.mkString
    }
    def main(args: Array[String]) = {
    assert(f((8999l), (2l)).equals(("08999")));
    }

}
