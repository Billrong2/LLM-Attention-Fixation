import scala.math._
import scala.collection.mutable._
object Problem {
    def f(txt : String) : Long = {
        var coincidences = scala.collection.mutable.Map[Char, Int]()
        for (c <- txt) {
            if (coincidences.contains(c)) {
                coincidences(c) += 1
            } else {
                coincidences(c) = 1
            }
        }
        return coincidences.values.sum
    }
    def main(args: Array[String]) = {
    assert(f(("11 1 1")) == (6l));
    }

}
