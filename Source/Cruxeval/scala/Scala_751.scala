import scala.annotation.tailrec
import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String, min_count : Long) : String = {
        val count = text.count(_ == char.head)
        if (count < min_count) {
            text.map{
                case c if c.isUpper => c.toLower
                case c if c.isLower => c.toUpper
                case c => c
            }
        } else {
            text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("wwwwhhhtttpp"), ("w"), (3l)).equals(("wwwwhhhtttpp")));
    }

}
