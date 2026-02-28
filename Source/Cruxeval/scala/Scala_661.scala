import scala.math._
import scala.collection.mutable._
object Problem {
    def f(letters : String, maxsplit : Long) : String = {
        letters.split(" ").takeRight(maxsplit.toInt).mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("elrts,SS ee"), (6l)).equals(("elrts,SSee")));
    }

}
