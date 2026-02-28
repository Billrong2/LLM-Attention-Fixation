import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dic : Map[String,Long]) : List[Tuple2[String, Long]] = {
        dic.toList.sortBy(_._1)
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("b" -> 1l, "a" -> 2l))).equals((List[Tuple2[String, Long]](("a", 2l), ("b", 1l)))));
    }

}
