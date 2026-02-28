import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var x = 0
        if (text.forall(_.isLower)) {
            for (c <- text) {
                if (c.toInt < 90 && c.toInt >= 48) {
                    x += 1
                }
            }
        }
        x
    }
    def main(args: Array[String]) = {
    assert(f(("591237865")) == (0l));
    }

}
