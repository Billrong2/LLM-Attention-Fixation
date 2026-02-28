import scala.math._
import scala.collection.mutable._
object Problem {
    def f(float_number : Float) : String = {
        val number = float_number.toString
        val dot = number.indexOf('.')
        if (dot != -1) {
            return number.substring(0, dot) + "." + number.substring(dot + 1).padTo(2, '0').mkString
        }
        return number + ".00"
    }
    def main(args: Array[String]) = {
    assert(f((3.121f)).equals(("3.121")));
    }

}
