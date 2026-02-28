import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String, insert: String): String = {
        val whitespaces = Set('\t', '\r', '\u000B', ' ', '\f', '\n')
        var clean = ""
        for (char <- text) {
            if (whitespaces.contains(char)) {
                clean += insert
            } else {
                clean += char
            }
        }
        clean
    }
    def main(args: Array[String]) = {
    assert(f(("pi wa"), ("chi")).equals(("pichiwa")));
    }

}
