import scala.math._
object Problem {
    def f(x : String, y : String) : String = {
        if (x.forall(_.isDigit) && y.reverse.forall(_.isDigit)) {
            x + y.reverse.map(c => if (c == '9') '0' else '9').mkString
        } else {
            x
        }
    }
    def main(args: Array[String]) = {
    assert(f((""), ("sdasdnakjsda80")).equals(("")));
    }

}
