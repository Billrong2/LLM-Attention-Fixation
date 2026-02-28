import scala.collection.mutable._
import scala.math._
object Problem {
    def f(n: Long, l: List[String]): Map[Long, Long] = {
        var archive: Map[Long, Long] = Map()

        for (_ <- 0 until n.toInt) {
            archive = collection.mutable.Map(l.map(x => (x.toInt + 10).toLong -> (x.toInt * 10).toLong): _*)
        }

        archive
    }
    def main(args: Array[String]) = {
    assert(f((0l), (List[String]("aaa", "bbb"))).equals((Map[Long,Long]())));
    }

}
