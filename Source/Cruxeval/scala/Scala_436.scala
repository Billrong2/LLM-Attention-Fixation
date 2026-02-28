import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : String, characters : List[Long]) : List[String] = {
        characters.map(i => s.substring(i.toInt, i.toInt + 1)).toList
    }
    def main(args: Array[String]) = {
    assert(f(("s7 6s 1ss"), (List[Long](1l.toLong, 3l.toLong, 6l.toLong, 1l.toLong, 2l.toLong))).equals((List[String]("7", "6", "1", "7", " "))));
    }

}
