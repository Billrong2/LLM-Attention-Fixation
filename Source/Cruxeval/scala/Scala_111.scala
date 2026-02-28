import scala.math._
import scala.collection.mutable._
object Problem {
    def f(marks : Map[String,Long]) : Tuple2[Long, Long] = {
        var highest = 0L
        var lowest = 100L
        marks.values.foreach { value =>
            if (value > highest) {
                highest = value
            }
            if (value < lowest) {
                lowest = value
            }
        }
        (highest, lowest)
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("x" -> 67l, "v" -> 89l, "" -> 4l, "alij" -> 11l, "kgfsd" -> 72l, "yafby" -> 83l))).equals(((89l, 4l))));
    }

}
