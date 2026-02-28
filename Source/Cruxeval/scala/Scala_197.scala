import scala.math._
import scala.collection.mutable._
object Problem {
    def f(temp : Long, timeLimit : Long) : String = {
        val s = timeLimit / temp
        val e = timeLimit % temp
        if (s > 1) {
            s + " " + e
        } else {
            e + " oC"
        }
    }
    def main(args: Array[String]) = {
    assert(f((1l), (1234567890l)).equals(("1234567890 0")));
    }

}
