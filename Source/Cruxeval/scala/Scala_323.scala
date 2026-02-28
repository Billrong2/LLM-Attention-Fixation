import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        text.split("\n").length
    }
    def main(args: Array[String]) = {
    assert(f(("ncdsdfdaaa0a1cdscsk*XFd")) == (1l));
    }

}
