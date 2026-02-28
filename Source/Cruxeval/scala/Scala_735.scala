import scala.math._
import scala.collection.mutable._
object Problem {
    def f(sentence : String) : String = {
        if (sentence == "") {
            return ""
        }
        var modifiedSentence = sentence.replace("(", "").replace(")", "")
        if (modifiedSentence.nonEmpty) {
            modifiedSentence = modifiedSentence.head.toUpper + modifiedSentence.tail.toLowerCase
        }
        modifiedSentence.replace(" ", "")
    }
    def main(args: Array[String]) = {
    assert(f(("(A (b B))")).equals(("Abb")));
    }

}
