import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : String = {
        try {
            var result = text
            while (result.contains("nnet lloP")) {
                result = result.replace("nnet lloP", "nnet loLp")
            }
            result
        } catch {
            case e: Exception => text
        }
    }
    def main(args: Array[String]) = {
    assert(f(("a_A_b_B3 ")).equals(("a_A_b_B3 ")));
    }

}
