import scala.math._
import scala.collection.mutable._
object Problem {
    def f(x : List[Long]) : Long = {
        if (x.isEmpty) {
            return -1
        } else {
            var cache = scala.collection.mutable.Map[Long, Long]()
            for (item <- x) {
                if (cache.contains(item)) {
                    cache(item) += 1
                } else {
                    cache(item) = 1
                }
            }
            cache.values.max
        }
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](1l.toLong, 0l.toLong, 2l.toLong, 2l.toLong, 0l.toLong, 0l.toLong, 0l.toLong, 1l.toLong))) == (4l));
    }

}
