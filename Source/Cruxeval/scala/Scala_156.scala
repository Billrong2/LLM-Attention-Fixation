import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, limit : Long, char : String) : String = {
        if (limit < text.length) {
            return text.substring(0, limit.toInt)
        } else {
            return text.padTo(limit.toInt, char.head).mkString
        }
    }
    def main(args: Array[String]) = {
    assert(f(("tqzym"), (5l), ("c")).equals(("tqzym")));
    }

}
