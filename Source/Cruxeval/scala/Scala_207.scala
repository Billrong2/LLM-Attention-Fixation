import scala.math._
import scala.collection.mutable._
object Problem {
    def f(commands : List[Map[String,Long]]) : Map[String,Long] = {
        var d = Map[String, Long]()
        for (c <- commands) {
            d = d ++ c
        }
        d
    }
    def main(args: Array[String]) = {
    assert(f((List[Map[String,Long]](Map[String,Long]("brown" -> 2l), Map[String,Long]("blue" -> 5l), Map[String,Long]("bright" -> 4l)))).equals((Map[String,Long]("brown" -> 2l, "blue" -> 5l, "bright" -> 4l))));
    }

}
