import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : List[String] = {
        val d = s.distinct
        List(d.map(_.toString).toList:_*)
    }
    def main(args: Array[String]) = {
    assert(f(("12ab23xy")).equals((List[String]("1", "2", "a", "b", "3", "x", "y"))));
    }

}
