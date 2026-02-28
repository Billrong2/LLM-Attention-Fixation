import scala.collection.mutable._
import scala.math._
object Problem {
    def f(d: Map[String, Any], count: Long): Map[String, Any] = {
        var mutableD = Map[String, Any]() ++ d
        var newDict = Map[String, Any]()
        for (_ <- 1L to count) {
            mutableD = mutableD.clone()
            newDict = mutableD ++ newDict
        }
        newDict
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Any]("a" -> 2l, "b" -> List[Long](), "c" -> Map[Long,Long]())), (0l)).equals((Map[String,Any]())));
    }

}
