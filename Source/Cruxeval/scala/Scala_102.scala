import scala.math._
import scala.collection.mutable._
object Problem {
    def f(names : List[String], winners : List[String]) : List[Long] = {
        val ls = names.zipWithIndex.collect {
            case (name, index) if winners.contains(name) => index.toLong
        }
        ls.sortBy(-_).toList
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("e", "f", "j", "x", "r", "k")), (List[String]("a", "v", "2", "im", "nb", "vj", "z"))).equals((List[Long]())));
    }

}
