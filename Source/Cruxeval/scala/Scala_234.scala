import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : Long = {
        var position = text.length
        if (text.contains(char)) {
            position = text.indexOf(char)
            if (position > 1) {
                position = (position + 1) % text.length
            }
        }
        position
    }
    def main(args: Array[String]) = {
    assert(f(("wduhzxlfk"), ("w")) == (0l));
    }

}
