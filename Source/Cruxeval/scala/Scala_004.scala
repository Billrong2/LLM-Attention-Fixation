import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[String]) : String = {
        var s = " "
        s += array.mkString("")
        s
    }
    def main(args: Array[String]) = {
    assert(f((List[String](" ", "  ", "    ", "   "))).equals(("           ")));
    }

}
