import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dic : Map[Long,String]) : Map[String,Long] = {
        val dic2 = dic.map(_.swap)
        dic2
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,String](-1l -> "a", 0l -> "b", 1l -> "c"))).equals((Map[String,Long]("a" -> -1l, "b" -> 0l, "c" -> 1l))));
    }

}
