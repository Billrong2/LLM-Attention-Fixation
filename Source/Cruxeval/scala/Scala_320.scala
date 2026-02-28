import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var index = 1
        while (index < text.length) {
            if (text(index) != text(index-1)) {
                index += 1
            } else {
                val text1 = text.slice(0, index)
                val text2 = text.slice(index, text.length).map(c => if (c.isLower) c.toUpper else c.toLower)
                return text1 + text2
            }
        }
        text.map(c => if (c.isLower) c.toUpper else c.toLower)
    }
    def main(args: Array[String]) = {
    assert(f(("USaR")).equals(("usAr")));
    }

}
