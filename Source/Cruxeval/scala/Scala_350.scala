import scala.math._
object Problem {
    def f(d : Map[String,Long]) : List[Long] = {
        val size = d.size
        val v = Array.fill[Long](size)(0)
        if (size == 0) {
            return v.toList
        }
        for ((e, i) <- d.zipWithIndex) {
            v(i.toInt) = e._2
        }
        v.toList
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("a" -> 1l, "b" -> 2l, "c" -> 3l))).equals((List[Long](1l.toLong, 2l.toLong, 3l.toLong))));
    }

}
