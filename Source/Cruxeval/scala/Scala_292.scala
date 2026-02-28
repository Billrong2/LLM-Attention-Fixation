import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val new_text = text.map(c => if (c.isDigit) c else '*')
        new_text.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("5f83u23saa")).equals(("5*83*23***")));
    }

}
