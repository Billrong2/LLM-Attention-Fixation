import scala.math._
import scala.collection.mutable._
object Problem {
    def f(d : Map[Long,Long], index : Long) : Long = {
        val length = d.size
        val idx = (index % length).toInt
        val v = d(d.keys.toList(idx))
        d -= d.keys.toList(idx)
        v
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,Long](27l -> 39l)), (1l)) == (39l));
    }

}
