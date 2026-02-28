import scala.math._
import scala.collection.mutable._
object Problem {
    def f(zoo : Map[String,String]) : Map[String,String] = {
        zoo.map(_.swap)
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,String]("AAA" -> "fr"))).equals((Map[String,String]("fr" -> "AAA"))));
    }

}
