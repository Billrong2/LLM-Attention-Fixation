import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s : List[Long]) : Long = {
        var s_mut = s.toBuffer
        while (s_mut.length > 1) {
            s_mut.clear()
            s_mut += s_mut.length
        }
        if (s_mut.nonEmpty) s_mut.last else 0
    }
    def main(args: Array[String]) = {
    assert(f((List[Long](6l.toLong, 1l.toLong, 2l.toLong, 3l.toLong))) == (0l));
    }

}
