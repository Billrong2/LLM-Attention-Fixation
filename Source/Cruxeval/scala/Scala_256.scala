import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, sub : String) : Long = {
        var a = 0
        var b = text.length - 1

        while (a <= b) {
            var c = (a + b) / 2
            if (text.lastIndexOf(sub) >= c) {
                a = c + 1
            } else {
                b = c - 1
            }
        }
        
        return a
    }
    def main(args: Array[String]) = {
    assert(f(("dorfunctions"), ("2")) == (0l));
    }

}
