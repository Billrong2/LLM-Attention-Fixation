import scala.math._
import scala.collection.mutable._
object Problem {
    def f(value : String) : String = {
        val parts = value.split(" ").grouped(2).map(_.head).toList
        parts.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("coscifysu")).equals(("coscifysu")));
    }

}
