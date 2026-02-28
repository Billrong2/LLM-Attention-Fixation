import scala.math._
import scala.collection.mutable._
object Problem {
    def f(concat : String, di : Map[String,String]) : String = {
        val count = di.size
        for (i <- 0 until count) {
            if (di.getOrElse(i.toString, "") == concat) {
                di -= i.toString
            }
        }
        "Done!"
    }
    def main(args: Array[String]) = {
    assert(f(("mid"), (Map[String,String]("0" -> "q", "1" -> "f", "2" -> "w", "3" -> "i"))).equals(("Done!")));
    }

}
