import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String, symbols : String) : String = {
        var count = 0
        var newText = text
        if (!symbols.isEmpty) {
            count = symbols.length
            newText = text * count
        }
        newText.padTo(text.length + count * 2, ' ').dropRight(2)
    }
    def main(args: Array[String]) = {
    assert(f((""), ("BC1ty")).equals(("        ")));
    }

}
