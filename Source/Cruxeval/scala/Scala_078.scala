import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        if (text != "" && text == text.toUpperCase) {
            val cs = text.toUpperCase.zip(text.toLowerCase).toMap
            text.map(cs)
        } else {
            text.toLowerCase.take(3)
        }
    }
    def main(args: Array[String]) = {
    assert(f(("mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n")).equals(("mty")));
    }

}
