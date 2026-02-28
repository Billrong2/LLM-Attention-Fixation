import scala.math._
import scala.collection.mutable._
object Problem {
    def f(phrase : String) : Long = {
        var ans = 0
        phrase.split(" ").foreach { w =>
            w.foreach { ch =>
                if (ch == '0') {
                    ans += 1
                }
            }
        }
        ans
    }
    def main(args: Array[String]) = {
    assert(f(("aboba 212 has 0 digits")) == (1l));
    }

}
