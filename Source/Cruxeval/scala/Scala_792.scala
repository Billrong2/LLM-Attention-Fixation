import scala.math._
import scala.collection.mutable._
object Problem {
    def f(l1 : List[String], l2 : List[String]) : Map[String,List[String]] = {
        if (l1.length != l2.length) {
            Map.empty
        } else {
            Map(l1.map(k => k -> l2): _*)
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("a", "b")), (List[String]("car", "dog"))).equals((Map[String,List[String]]("a" -> List[String]("car", "dog"), "b" -> List[String]("car", "dog")))));
    }

}
