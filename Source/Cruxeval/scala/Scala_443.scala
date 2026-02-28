import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var updatedText = text
        for (space <- text) {
            if (space == ' ') {
                updatedText = updatedText.trim()
            } else {
                updatedText = updatedText.replace("cd", space.toString)
            }
        }
        updatedText
    }
    def main(args: Array[String]) = {
    assert(f(("lorem ipsum")).equals(("lorem ipsum")));
    }

}
