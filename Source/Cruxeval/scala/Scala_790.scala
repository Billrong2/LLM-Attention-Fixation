import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[String,String]) : Tuple2[Boolean, Boolean] = {
        var r = Map(
            "c" -> d.clone(),
            "d" -> d.clone()
        )
        return (r("c") eq r("d"), r("c") == r("d"))
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,String]("i" -> "1", "love" -> "parakeets"))).equals(((false, true))));
    }

}
