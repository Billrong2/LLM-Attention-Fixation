import scala.math._
import scala.collection.mutable._
object Problem {
    def f(letters : List[String]) : String = {
        var a = List[String]()
        for (i <- 0 until letters.length) {
            if (a.contains(letters(i))) {
                return "no"
            }
            a = a :+ letters(i)
        }
        return "yes"
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("b", "i", "r", "o", "s", "j", "v", "p"))).equals(("yes")));
    }

}
