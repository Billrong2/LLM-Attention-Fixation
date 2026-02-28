import scala.collection.mutable._
import scala.math._
object Problem {
    def f(li: List[String]): List[Int] = {
        li.map(i => li.count(_ == i))
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("k", "x", "c", "x", "x", "b", "l", "f", "r", "n", "g"))).equals((List[Long](1l.toLong, 3l.toLong, 1l.toLong, 3l.toLong, 3l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong))));
    }

}
