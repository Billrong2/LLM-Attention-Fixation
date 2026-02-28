import scala.math._
import scala.collection.mutable._
object Problem {
    def f(file : String) : Long = {
        file.indexOf('\n')
    }
    def main(args: Array[String]) = {
    assert(f(("n wez szize lnson tilebi it 504n.\n")) == (33l));
    }

}
