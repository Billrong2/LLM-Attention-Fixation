import scala.math._
import scala.collection.mutable._
object Problem {
    def f(num : Long) : Long = {
        var initial = List(1L)
        var total = initial
        for (i <- 0 until num.toInt) {
            total = 1L +: total.zip(total.drop(1)).map{ case (x, y) => x + y }
            initial = initial :+ total.last
        }
        initial.sum
    }
    def main(args: Array[String]) = {
    assert(f((3l)) == (4l));
    }

}
