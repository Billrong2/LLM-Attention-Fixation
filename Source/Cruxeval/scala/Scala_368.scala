import scala.collection.mutable._
import scala.math._
object Problem {
    def f(string : String, numbers : List[Long]) : String = {
        val arr = numbers.map(num => string.reverse.padTo(num.toInt, '0').reverse.mkString)
        arr.mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f(("4327"), (List[Long](2l.toLong, 8l.toLong, 9l.toLong, 2l.toLong, 7l.toLong, 1l.toLong))).equals(("4327 00004327 000004327 4327 0004327 4327")));
    }

}
