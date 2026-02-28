import scala.math._
import scala.collection.mutable._
object Problem {
    def f(sequence : String, value : String) : String = {
        val i = max(sequence.indexOf(value) - sequence.length() / 3, 0)
        var result = ""
        for ((v, j) <- sequence.substring(i).zipWithIndex) {
            if (v == '+') {
                result += value
            } else {
                result += sequence(i + j)
            }
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("hosu"), ("o")).equals(("hosu")));
    }

}
