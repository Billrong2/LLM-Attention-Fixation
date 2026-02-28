import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        var short = ""
        for(c <- text) {
            if(c.isLower) {
                short += c
            }
        }
        short
    }
    def main(args: Array[String]) = {
    assert(f(("980jio80jic kld094398IIl ")).equals(("jiojickldl")));
    }

}
