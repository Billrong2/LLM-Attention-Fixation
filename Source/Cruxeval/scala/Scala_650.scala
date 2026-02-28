import scala.math._
import scala.collection.mutable._
object Problem {
    def f(string : String, substring : String) : String = {
        var updatedString = string
        while(updatedString.startsWith(substring)){
            updatedString = updatedString.substring(substring.length)
        }
        updatedString
    }
    def main(args: Array[String]) = {
    assert(f((""), ("A")).equals(("")));
    }

}
