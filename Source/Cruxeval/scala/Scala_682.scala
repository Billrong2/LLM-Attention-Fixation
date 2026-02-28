import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, length : Long, index : Long) : String = {
        val ls = text.split("\\s+").takeRight(index.toInt)
        ls.map(_.take(length.toInt)).mkString("_")
    }
    def main(args: Array[String]) = {
    assert(f(("hypernimovichyp"), (2l), (2l)).equals(("hy")));
    }

}
