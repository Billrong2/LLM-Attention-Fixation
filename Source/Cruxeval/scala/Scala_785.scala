import scala.math._
import scala.collection.mutable._
object Problem {
    def f(n : Long) : String = {
        var streak = ""
        for (c <- n.toString) {
            streak += c.toString.padTo(c.asDigit * 2, ' ')
        }
        streak
    }
    def main(args: Array[String]) = {
    assert(f((1l)).equals(("1 ")));
    }

}
