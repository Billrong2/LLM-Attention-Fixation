import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, letter : String) : String = {
        if (text.contains(letter)) {
            val start = text.indexOf(letter)
            return text.substring(start + 1) + text.substring(0, start + 1)
        }
        text
    }
    def main(args: Array[String]) = {
    assert(f(("19kefp7"), ("9")).equals(("kefp719")));
    }

}
