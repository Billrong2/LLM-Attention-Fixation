import scala.math._
import scala.collection.mutable._
object Problem {
    def f(a : String, b : List[String]) : String = {
        return b.mkString(a)
    }
    def main(args: Array[String]) = {
    assert(f(("00"), (List[String]("nU", " 9 rCSAz", "w", " lpA5BO", "sizL", "i7rlVr"))).equals(("nU00 9 rCSAz00w00 lpA5BO00sizL00i7rlVr")));
    }

}
