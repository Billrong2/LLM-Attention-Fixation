import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Boolean = {
        text.toUpperCase == text
    }
    def main(args: Array[String]) = {
    assert(f(("VTBAEPJSLGAHINS")) == (true));
    }

}
