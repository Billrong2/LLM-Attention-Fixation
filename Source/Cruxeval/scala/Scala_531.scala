import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, x : String) : String = {
        if (text.dropWhile(_ == x.head) == text) {
            f(text.tail, x)
        } else {
            text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("Ibaskdjgblw asdl "), ("djgblw")).equals(("djgblw asdl ")));
    }

}
