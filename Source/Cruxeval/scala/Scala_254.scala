import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, repl : String) : String = {
        val trans = text.toLowerCase.zip(repl.toLowerCase).toMap
        text.map(c => trans.getOrElse(c, c).toString).mkString
    }
    def main(args: Array[String]) = {
    assert(f(("upper case"), ("lower case")).equals(("lwwer case")));
    }

}
