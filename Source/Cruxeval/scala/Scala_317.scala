import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, a : String, b : String) : String = {
        var newText = text.replace(a, b)
        return newText.replace(b, a)
    }
    def main(args: Array[String]) = {
    assert(f((" vup a zwwo oihee amuwuuw! "), ("a"), ("u")).equals((" vap a zwwo oihee amawaaw! ")));
    }

}
