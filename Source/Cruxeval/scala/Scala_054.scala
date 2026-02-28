import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, s : Long, e : Long) : Long = {
        val sublist = text.substring(s.toInt, e.toInt)
        if (sublist.isEmpty) {
            return -1
        }
        sublist.indexOf(sublist.min)
    }
    def main(args: Array[String]) = {
    assert(f(("happy"), (0l), (3l)) == (1l));
    }

}
