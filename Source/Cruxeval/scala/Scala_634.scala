import scala.math._
import scala.collection.mutable._
object Problem {
    def f(input_string : String) : String = {
        val table = Map('a' -> 'i', 'i' -> 'o', 'o' -> 'u', 'e' -> 'a', 'A' -> 'I', 'I' -> 'O', 'O' -> 'U', 'E' -> 'A')
        var modifiedString = input_string
        while (modifiedString.contains('a') || modifiedString.contains('A')) {
            modifiedString = modifiedString.map(c => table.getOrElse(c, c))
        }
        modifiedString
    }
    def main(args: Array[String]) = {
    assert(f(("biec")).equals(("biec")));
    }

}
