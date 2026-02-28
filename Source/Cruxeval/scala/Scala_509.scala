import scala.math._
import scala.collection.mutable._
object Problem {
    def f(value : Long, width : Long) : String = {
        if (value >= 0) {
            return value.toString.reverse.padTo(width.toInt, '0').reverse.mkString
        } else {
            return "-" + (-value).toString.reverse.padTo(width.toInt, '0').reverse.mkString
        }
    }
    def main(args: Array[String]) = {
    assert(f((5l), (1l)).equals(("5")));
    }

}
