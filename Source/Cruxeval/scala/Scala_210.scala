import scala.math._
import scala.collection.mutable._
object Problem {
    def f(n : Long, m : Long, num : Long) : Long = {
        var x_list = (n to m).toList
        var j = 0
        while (true) {
            j = (j + num.toInt) % x_list.length
            if (x_list(j) % 2 == 0) {
                return x_list(j)
            }
        }
        return 0  // This line is necessary as Scala requires an explicit return for all code paths
    }
    def main(args: Array[String]) = {
    assert(f((46l), (48l), (21l)) == (46l));
    }

}
