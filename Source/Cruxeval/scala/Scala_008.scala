import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String, encryption : Long) : String = {
        if (encryption == 0) {
            string
        } else {
            string.toUpperCase.map { c =>
                if (c.isLetter) {
                    val base = if (c.isLower) 'a' else 'A'
                    ((c - base + encryption) % 26 + base).toChar
                } else {
                    c
                }
            }
        }
    }
    def main(args: Array[String]) = {
    assert(f(("UppEr"), (0l)).equals(("UppEr")));
    }

}
