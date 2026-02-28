import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, suffix : String) : String = {
        var output = text
        while(output.endsWith(suffix)){
            output = output.substring(0, output.length - suffix.length)
        }
        output
    }
    def main(args: Array[String]) = {
    assert(f(("!klcd!ma:ri"), ("!")).equals(("!klcd!ma:ri")));
    }

}
