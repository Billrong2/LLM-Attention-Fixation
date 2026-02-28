import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val texts = text.split(" ")
        if (texts.nonEmpty) {
            val xtexts = texts.filter(t => t.matches("\\A\\p{ASCII}+\\z") && t != "nada" && t != "0")
            if (xtexts.nonEmpty) {
                return xtexts.maxBy(_.length)
            } else {
                return "nada"
            }
        }
        return "nada"
    }
    def main(args: Array[String]) = {
    assert(f(("")).equals(("nada")));
    }

}
