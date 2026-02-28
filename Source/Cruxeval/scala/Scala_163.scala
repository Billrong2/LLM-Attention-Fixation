import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, space_symbol : String, size : Long) : String = {
        val spaces = space_symbol * Math.max(0, size - text.length).toInt
        text + spaces
    }
    def main(args: Array[String]) = {
    assert(f(("w"), ("))"), (7l)).equals(("w))))))))))))")));
    }

}
