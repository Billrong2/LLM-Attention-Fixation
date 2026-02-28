import scala.math._
import scala.collection.mutable._
object Problem {
    def f(query : String, base : Map[String,Long]) : Long = {
        var net_sum = 0L
        for ((key, value) <- base) {
            if (key.charAt(0) == query && key.length == 3) {
                net_sum -= value
            } else if (key.charAt(key.length - 1) == query && key.length == 3) {
                net_sum += value
            }
        }
        net_sum
    }
    def main(args: Array[String]) = {
    assert(f(("a"), (Map[String,Long]())) == (0l));
    }

}
