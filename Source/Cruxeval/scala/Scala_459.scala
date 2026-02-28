import scala.math._
import scala.collection.mutable._
object Problem {
    def f(arr : List[String], d : Map[String,String]) : Map[String,String] = {
        for (i <- 1 until(arr.length, 2)) {
            d += (arr(i) -> arr(i-1))
        }
        d
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("b", "vzjmc", "f", "ae", "0")), (Map[String,String]())).equals((Map[String,String]("vzjmc" -> "b", "ae" -> "f"))));
    }

}
