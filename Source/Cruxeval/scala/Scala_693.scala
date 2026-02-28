import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val n = text.indexOf('8')
        "x0" * n
    }
    def main(args: Array[String]) = {
    assert(f(("sa832d83r xd 8g 26a81xdf")).equals(("x0x0")));
    }

}
