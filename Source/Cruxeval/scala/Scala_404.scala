import scala.math._
import scala.collection.mutable._
object Problem {
    def f(no : List[String]) : Long = {
        val d = no.map((_, false)).toMap
        d.keys.toList.length
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("l", "f", "h", "g", "s", "b"))) == (6l));
    }

}
