import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, characters : String) : String = {
        val character_list = characters.toList :+ ' ' :+ '_'

        var i = 0
        while (i < text.length && character_list.contains(text(i))) {
            i += 1
        }

        text.substring(i)
    }
    def main(args: Array[String]) = {
    assert(f(("2nm_28in"), ("nm")).equals(("2nm_28in")));
    }

}
