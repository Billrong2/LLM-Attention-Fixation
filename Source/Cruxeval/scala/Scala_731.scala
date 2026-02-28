import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, use : String) : String = {
        text.replaceAllLiterally(use, "")
    }
    def main(args: Array[String]) = {
    assert(f(("Chris requires a ride to the airport on Friday."), ("a")).equals(("Chris requires  ride to the irport on Fridy.")));
    }

}
