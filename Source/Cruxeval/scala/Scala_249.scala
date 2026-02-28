import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String) : Map[String,Long] = {
        var count: Map[String, Long] = Map()
        for (i <- s) {
            if (i.isLower) {
                count += (i.toString.toLowerCase -> (s.count(_ == i.toLower) + count.getOrElse(i.toString.toLowerCase, 0l)))
            } else {
                count += (i.toString.toLowerCase -> (s.count(_ == i.toUpper) + count.getOrElse(i.toString.toLowerCase, 0l)))
            }
        }
        count
    }
    def main(args: Array[String]) = {
    assert(f(("FSA")).equals((Map[String,Long]("f" -> 1l, "s" -> 1l, "a" -> 1l))));
    }

}
