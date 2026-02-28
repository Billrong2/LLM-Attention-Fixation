import scala.math._
import scala.collection.mutable._
object Problem {
    def f(numbers : List[Long]) : List[Float] = {
        val floats = numbers.map(n => (n % 1).toFloat)
        if (floats.contains(1f)) floats else List()
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](100l.toLong, 101l.toLong, 102l.toLong, 103l.toLong, 104l.toLong, 105l.toLong, 106l.toLong, 107l.toLong, 108l.toLong, 109l.toLong, 110l.toLong, 111l.toLong, 112l.toLong, 113l.toLong, 114l.toLong, 115l.toLong, 116l.toLong, 117l.toLong, 118l.toLong, 119l.toLong))).equals((List[Float]())));
    }

}
