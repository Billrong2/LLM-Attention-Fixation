import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var newText = text.replace(" x", " x.")
        if (newText.equals(newText.capitalize)) return "correct"
        newText = newText.replace(" x.", " x")
        "mixed"
    }
    def main(args: Array[String]) = {
    assert(f(("398 Is A Poor Year To Sow")).equals(("correct")));
    }

}
