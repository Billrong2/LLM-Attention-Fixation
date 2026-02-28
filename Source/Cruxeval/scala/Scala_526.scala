import scala.math._
import scala.collection.mutable._
object Problem {
    def f(label1 : String, char : String, label2 : String, index : Long) : String = {
        val m = label1.lastIndexOf(char)
        if (m >= index) {
            label2.slice(0, (m - index + 1).toInt)
        } else {
            label1 + label2.slice(index.toInt - m - 1, label2.length)
        }
    }
    def main(args: Array[String]) = {
    assert(f(("ekwies"), ("s"), ("rpg"), (1l)).equals(("rpg")));
    }

}
