import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : List[Long] = {
        var occ = Map[Char, Long]()
        for (ch <- text) {
            val name = Map('a' -> 'b', 'b' -> 'c', 'c' -> 'd', 'd' -> 'e', 'e' -> 'f').withDefaultValue(ch)
            val updatedChar = name(ch)
            occ += (updatedChar -> (occ.getOrElse(updatedChar, 0L) + 1))
        }
        occ.values.toList
    }
    def main(args: Array[String]) = {
    assert(f(("URW rNB")).equals((List[Long](1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong, 1l.toLong))));
    }

}
