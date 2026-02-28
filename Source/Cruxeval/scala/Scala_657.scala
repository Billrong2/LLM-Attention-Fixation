import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        val punctuations = List(".", "!", "?", ",", ":", ";")
        for (punct <- punctuations) {
            if (text.count(_ == punct.charAt(0)) > 1 || text.endsWith(punct)) {
                return "no"
            }
        }
        text.capitalize
    }
    def main(args: Array[String]) = {
    assert(f(("djhasghasgdha")).equals(("Djhasghasgdha")));
    }

}
