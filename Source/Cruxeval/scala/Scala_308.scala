import scala.math._
import scala.collection.mutable._
object Problem {
    def f(strings : List[String]) : Map[String,Long] = {
        var occurances = Map[String, Long]()
        for (string <- strings) {
            if (!occurances.contains(string)) {
                occurances += (string -> strings.count(_ == string))
            }
        }
        occurances
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("La", "Q", "9", "La", "La"))).equals((Map[String,Long]("La" -> 3l, "Q" -> 1l, "9" -> 1l))));
    }

}
