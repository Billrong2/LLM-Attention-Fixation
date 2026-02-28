import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, value : String) : String = {
        text.padTo(value.length, '?')
    }
    def main(args: Array[String]) = {
    assert(f(("!?"), ("")).equals(("!?")));
    }

}
