import scala.math._
import scala.collection.mutable._
object Problem {
    def f(phrase : String) : String = {
        var result: String = ""
        for (i <- phrase) {
            if (!i.isLower) {
                result += i
            }
        }
        result
    }
    def main(args: Array[String]) = {
    assert(f(("serjgpoDFdbcA.")).equals(("DFA.")));
    }

}
