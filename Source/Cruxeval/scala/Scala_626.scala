import scala.math._
import scala.collection.mutable._
object Problem {
    def f(line : String, equalityMap : List[Tuple2[String, String]]) : String = {
        val rs = equalityMap.toMap
        line.map(c => rs.getOrElse(c.toString, c.toString)).mkString
    }
    def main(args: Array[String]) = {
    assert(f(("abab"), (List[Tuple2[String, String]](("a", "b"), ("b", "a")))).equals(("baba")));
    }

}
