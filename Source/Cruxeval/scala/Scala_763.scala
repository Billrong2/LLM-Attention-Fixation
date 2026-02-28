import scala.collection.mutable._
import scala.math._
object Problem {
    def f(values: String, text: String, markers: String): String = {
        text.reverse.dropWhile(c => values.contains(c)).reverse.dropWhile(c => markers.contains(c))
    }
    def main(args: Array[String]) = {
    assert(f(("2Pn"), ("yCxpg2C2Pny2"), ("")).equals(("yCxpg2C2Pny")));
    }

}
