import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        text.indexOf(",")
    }
    def main(args: Array[String]) = {
    assert(f(("There are, no, commas, in this text")) == (9l));
    }

}
