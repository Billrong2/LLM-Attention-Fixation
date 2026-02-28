import scala.math._
object Problem {
    def f(strands : List[String]) : String = {
        strands.map { strand => 
            val length = strand.length
            if (length > 1) {
                val last = strand.last
                val rotatedStrand = strand.dropRight(1).slice(1, length)
                last + rotatedStrand + strand.head
            } else {
                strand
            }
        }.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f((List[String]("__", "1", ".", "0", "r0", "__", "a_j", "6", "__", "6"))).equals(("__1.00r__j_a6__6")));
    }

}
