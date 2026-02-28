import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        !text.exists(_.isUpper)
    }
    def main(args: Array[String]) = {
    assert(f(("lunabotics")) == (true));
    }

}
