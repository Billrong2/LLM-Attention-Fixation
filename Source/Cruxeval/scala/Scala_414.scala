import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[String,List[String]]) : Map[String,List[String]] = {
        val dCopy = d.map { case (k, v) =>
            (k, v.map(_.toUpperCase))
        }
        dCopy
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,List[String]]("X" -> List[String]("x", "y")))).equals((Map[String,List[String]]("X" -> List[String]("X", "Y")))));
    }

}
