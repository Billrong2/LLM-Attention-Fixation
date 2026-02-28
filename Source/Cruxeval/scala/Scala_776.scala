import scala.math._
import scala.collection.mutable._

object Problem {
    def f(dictionary : Map[Long,Long]) : Map[String,Long] = {
        var a : Map[String,Long] = dictionary.asInstanceOf[Map[String,Long]]
        for (key <- dictionary.keys) {
            if (key % 2 != 0) {
                a -= key.toString
                a += ("$" + key.toString -> a(key.toString))
            }
        }
        a
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long]())).equals((Map[String,Long]())));
    }

}
