import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String): String = {
        var newText = text
        var currentText = text
        while (currentText.length > 1 && currentText(0) == currentText(currentText.length - 1)) {
            newText = currentText
            currentText = currentText.substring(1, currentText.length - 1)
        }
        newText
    }
    def main(args: Array[String]) = {
    assert(f((")")).equals((")")));
    }

}
