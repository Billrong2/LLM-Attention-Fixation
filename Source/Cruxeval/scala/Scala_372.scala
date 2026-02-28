import scala.math._
import scala.collection.mutable._
object Problem {
    def f(list_ : List[String], num : Long) : List[String] = {
        var temp: List[String] = List()
        for (i <- list_) {
            val newItem = List.fill(num.toInt / 2)(s"$i,").mkString
            temp = temp :+ newItem
        }
        temp
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("v")), (1l)).equals((List[String](""))));
    }

}
