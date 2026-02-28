import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d1 : Map[Long,List[Long]], d2 : Map[Long,List[Long]]) : Long = {
        var mmax = 0
        for ((k1, v1) <- d1) {
            val p = v1.size + d2.getOrElse(k1, List()).size
            if (p > mmax) {
                mmax = p
            }
        }
        mmax
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,List[Long]](0l -> List[Long](), 1l -> List[Long]())), (Map[Long,List[Long]](0l -> List[Long](0l.toLong, 0l.toLong, 0l.toLong, 0l.toLong), 2l -> List[Long](2l.toLong, 2l.toLong, 2l.toLong)))) == (4l));
    }

}
