import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var result: String = ""
        for (char <- text) {
            if (char.isLetterOrDigit) {
                result += char.toUpper
            }
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("с bishop.Swift")).equals(("СBISHOPSWIFT")));
    }

}
