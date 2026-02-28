import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        text.count(_.isDigit)
    }
    def main(args: Array[String]) = {
    assert(f(("so456")) == (3l));
    }

}
