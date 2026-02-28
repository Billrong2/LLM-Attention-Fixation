import scala.math._
import scala.collection.mutable._
object Problem {
    def f(x : String) : Long = {
        var a = 0
        for (i <- x.split(" ")) {
            a += i.reverse.padTo(i.length * 2, '0').reverse.length
        }
        a
    }
    def main(args: Array[String]) = {
    assert(f(("999893767522480")) == (30l));
    }

}
