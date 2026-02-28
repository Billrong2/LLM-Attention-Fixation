import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        text.split("\n").mkString(", ")
    }
    def main(args: Array[String]) = {
    assert(f(("BYE\nNO\nWAY")).equals(("BYE, NO, WAY")));
    }

}
