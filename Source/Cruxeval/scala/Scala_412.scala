import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable._
import scala.math._
object Problem {
    def f(start: Long, end: Long, interval: Long): Long = {
        val steps = ArrayBuffer.range(start, end + 1, interval.toInt)
        if (steps.contains(1)) steps(steps.length - 1) = end + 1
        steps.length
    }
    def main(args: Array[String]) = {
    assert(f((3l), (10l), (1l)) == (8l));
    }

}
