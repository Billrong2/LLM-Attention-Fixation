import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text : String, chars : String) : String = {
        var num_applies: Int = 2
        var extra_chars: String = ""
        var mutableText = text
        for (i <- 0 until num_applies) {
            extra_chars += chars
            mutableText = mutableText.replace(extra_chars, "")
        }
        mutableText
    }
    def main(args: Array[String]) = {
    assert(f(("zbzquiuqnmfkx"), ("mk")).equals(("zbzquiuqnmfkx")));
    }

}
