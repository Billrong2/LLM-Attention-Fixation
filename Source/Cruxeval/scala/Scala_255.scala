import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, fill : String, size : Long) : String = {
        val newSize = if (size < 0) -size else size
        if (text.length > newSize) {
            text.slice(text.length - newSize.toInt, text.length)
        } else {
            text.reverse.padTo(newSize.toInt, fill).reverse.mkString("")
        }
    }
    def main(args: Array[String]) = {
    assert(f(("no asw"), ("j"), (1l)).equals(("w")));
    }

}
