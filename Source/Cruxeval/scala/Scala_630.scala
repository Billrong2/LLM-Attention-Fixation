import scala.math._
import scala.collection.mutable._
object Problem {
    def f(original : Map[Long,Long], string : Map[Long,Long]) : Map[Long,Long] = {
        var temp = original
        for ((a, b) <- string) {
            temp = temp + (b -> a)
        }
        temp
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long](1l -> -9l, 0l -> -7l)), (Map[Long,Long](1l -> 2l, 0l -> 3l))).equals((Map[Long,Long](1l -> -9l, 0l -> -7l, 2l -> 1l, 3l -> 0l))));
    }

}
