import scala.collection.immutable.Map

object Problem {
    def f(a : Map[Long,String]) : String = {
        val s = a.toSeq.reverse
        s.map(pair => "(" + pair._1 + ", '" + pair._2 + "')").mkString(" ")
    }
    def main(args: Array[String]) = {
    assert(f((Map[Long,String](15l -> "Qltuf", 12l -> "Rwrepny"))).equals(("(12, 'Rwrepny') (15, 'Qltuf')")));
    }

}
