import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, digit : String) : Long = {
        val count = text.count(_ == digit.head)
        return digit.toInt * count
    }
    def main(args: Array[String]) = {
    assert(f(("7Ljnw4Lj"), ("7")) == (7l));
    }

}
