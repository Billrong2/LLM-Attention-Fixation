import scala.math._
import scala.collection.mutable._
object Problem {
    def f(my_dict : Map[String,Long]) : Map[Long,String] = {
        val result = my_dict.map(_.swap)
        result
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("a" -> 1l, "b" -> 2l, "c" -> 3l, "d" -> 2l))).equals((Map[Long,String](1l -> "a", 2l -> "d", 3l -> "c"))));
    }

}
