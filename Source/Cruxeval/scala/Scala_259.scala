import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var new_text = new ListBuffer[Char]()
        for (character <- text) {
            if (character.isUpper) {
                new_text.insert(new_text.length / 2, character)
            }
        }
        if (new_text.isEmpty) {
            new_text += '-'
        }
        new_text.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("String matching is a big part of RexEx library.")).equals(("RES")));
    }

}
