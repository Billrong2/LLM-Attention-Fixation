import scala.math._
import scala.collection.mutable._
object Problem {
    def f(n : String, m : String, text : String) : String = {
        if (text.trim.isEmpty) {
            return text
        }
        val head = text.head.toString
        val mid = text.tail.init
        val tail = text.last.toString
        val joined = head.replace(n, m) + mid.replace(n, m) + tail.replace(n, m)
        joined
    }
    def main(args: Array[String]) = {
    assert(f(("x"), ("$"), ("2xz&5H3*1a@#a*1hris")).equals(("2$z&5H3*1a@#a*1hris")));
    }

}
