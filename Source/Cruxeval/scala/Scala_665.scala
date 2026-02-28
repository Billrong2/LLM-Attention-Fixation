import scala.math._
import scala.collection.mutable._
object Problem {
    def f(chars : String) : String = {
        var s = ""
        for(ch <- chars) {
            if(chars.count(_ == ch) % 2 == 0) {
                s += ch.toUpper
            } else {
                s += ch
            }
        }
        s
    }
    def main(args: Array[String]) = {
    assert(f(("acbced")).equals(("aCbCed")));
    }

}
