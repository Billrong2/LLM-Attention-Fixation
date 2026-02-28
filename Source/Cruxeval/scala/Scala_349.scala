import scala.math._
import scala.collection.mutable._
object Problem {
    def f(dictionary : Map[String,Long]) : Map[String,Long] = {
        val newDict = dictionary + ("1049" -> 55l)
        val (key, value) = newDict.head
        newDict - key + (key -> value)
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("noeohqhk" -> 623l))).equals((Map[String,Long]("noeohqhk" -> 623l, "1049" -> 55l))));
    }

}
