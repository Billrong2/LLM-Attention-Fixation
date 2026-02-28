import scala.math._
import scala.collection.mutable._
object Problem {
    def f(plot : List[Long], delin : Long) : List[Long] = {
        if (plot.contains(delin)) {
            val split = plot.indexOf(delin)
            val first = plot.take(split)
            val second = plot.drop(split + 1)
            return first ++ second
        } else {
            return plot
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 2l.toLong, 3l.toLong, 4l.toLong)), (3l)).equals((List[Long](1l.toLong, 2l.toLong, 4l.toLong))));
    }

}
