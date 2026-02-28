import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, new_value : String, index : Long) : String = {
        val key = text.map(c => if (c == text(index.toInt)) new_value else c)
        key.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("spain"), ("b"), (4l)).equals(("spaib")));
    }

}
