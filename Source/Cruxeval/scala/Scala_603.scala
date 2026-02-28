import scala.math._
import scala.collection.mutable._
object Problem {
    def f(sentences : String) : String = {
        val isOscillating = sentences.split('.').forall(sentence => sentence.forall(_.isDigit))
        if (isOscillating) {
            return "oscillating"
        } else {
            return "not oscillating"
        }
    }
    def main(args: Array[String]) = {
    assert(f(("not numbers")).equals(("not oscillating")));
    }

}
