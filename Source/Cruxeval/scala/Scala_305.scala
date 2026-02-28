import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char : String) : String = {
        val length = text.length
        var index = -1
        for (i <- 0 until length) {
            if (text(i).toString == char) {
                index = i
            }
        }
        if (index == -1) {
            index = length / 2
        }
        val new_text = text.patch(index, Nil, 1)
        new_text
    }
    def main(args: Array[String]) = {
    assert(f(("o horseto"), ("r")).equals(("o hoseto")));
    }

}
