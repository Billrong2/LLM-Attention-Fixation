import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, position : Long) : String = {
        val length = text.length
        var index = (position % (length + 1)).toInt
        if (position < 0 || index < 0) {
            index = -1
        }
        val new_text = text.patch(index, Nil, 1)
        new_text
    }
    def main(args: Array[String]) = {
    assert(f(("undbs l"), (1l)).equals(("udbs l")));
    }

}
