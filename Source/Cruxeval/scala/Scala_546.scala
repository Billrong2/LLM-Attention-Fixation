import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, speaker : String) : String = {
        var updatedText = text
        while (updatedText.startsWith(speaker)) {
            updatedText = updatedText.substring(speaker.length)
        }
        updatedText
    }
    def main(args: Array[String]) = {
    assert(f(("[CHARRUNNERS]Do you know who the other was? [NEGMENDS]"), ("[CHARRUNNERS]")).equals(("Do you know who the other was? [NEGMENDS]")));
    }

}
