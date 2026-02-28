import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String, old : String, replacement : String) : String = {
        if (old.length > 3) {
            return text
        }
        if (text.contains(old) && !text.contains(" ")) {
            return text.replaceAllLiterally(old, replacement * old.length)
        }
        var newText = text
        while (newText.contains(old)) {
            newText = newText.replace(old, replacement)
        }
        newText
    }
    def main(args: Array[String]) = {
    assert(f(("avacado"), ("va"), ("-")).equals(("a--cado")));
    }

}
