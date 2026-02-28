import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, changes : String) : String = {
        var result = ""
        var count = 0
        val changesList = changes.toList
        for (char <- text) {
            if ("e".contains(char)) {
                result += char
            } else {
                result += changesList(count % changesList.length)
            }
            count += (if ("e".contains(char)) 0 else 1)
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("fssnvd"), ("yes")).equals(("yesyes")));
    }

}
