import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        val s = text.split("\n")
        s.length
    }
    def main(args: Array[String]) = {
    assert(f(("145\n\n12fjkjg")) == (3l));
    }

}
