import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        for(i <- 1 until text.length) {
            if (text(i) == text(i).toUpper && text(i - 1).isLower) {
                return true
            }
        }
        false
    }
    def main(args: Array[String]) = {
    assert(f(("jh54kkk6")) == (true));
    }

}
