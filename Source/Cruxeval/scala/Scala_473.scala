import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, value : String) : String = {
        var indexes = ListBuffer[Int]()
        for (i <- 0 until text.length) {
            if (text.charAt(i).toString == value) {
                indexes += i
            }
        }
        var new_text = text.toList
        for (i <- indexes) {
            new_text = new_text.filter(_ != value.charAt(0))
        }
        new_text.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("scedvtvotkwqfoqn"), ("o")).equals(("scedvtvtkwqfqn")));
    }

}
