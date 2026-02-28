import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        if(text.matches("[\\p{ASCII}]+")){
            return "ascii"
        } else {
            return "non ascii"
        }
    }
    def main(args: Array[String]) = {
    assert(f(("<<<<")).equals(("ascii")));
    }

}
