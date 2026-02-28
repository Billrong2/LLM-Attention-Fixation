import scala.math._
import scala.collection.mutable._
object Problem {
    def f(array : List[String], arr : List[String]) : List[String] = {
        var result: List[String] = List()
        for (s <- arr) {
            result = result ++ s.split(arr(array.indexOf(s))).filter(_.nonEmpty).toList
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f((List[String]()), (List[String]())).equals((List[String]())));
    }

}
