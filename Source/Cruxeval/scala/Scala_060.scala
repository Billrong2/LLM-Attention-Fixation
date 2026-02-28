import scala.math._
import scala.collection.mutable._
object Problem {
    def f(doc : String) : String = {
        for (x <- doc) {
            if (x.isLetter) {
                return x.toString.toUpperCase
            }
        }
        return "-"
    }
    def main(args: Array[String]) = {
    assert(f(("raruwa")).equals(("R")));
    }

}
