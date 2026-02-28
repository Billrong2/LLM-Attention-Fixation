import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, value : String) : String = {
        val length = text.length
        val letters = text.toList
        val valChar = value.head
        if (!letters.contains(valChar)) {
            return letters.head.toString * length
        }
        valChar.toString * length
    }
    def main(args: Array[String]) = {
    assert(f(("ldebgp o"), ("o")).equals(("oooooooo")));
    }

}
