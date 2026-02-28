import scala.math._
import scala.collection.mutable._
object Problem {
    def f(st : String) : String = {
        if (st.charAt(0) == '~') {
            val e = st.reverse.padTo(10, 's').reverse.mkString
            return f(e)
        } else {
            return st.reverse.padTo(10, 'n').reverse.mkString
        }
    }
    def main(args: Array[String]) = {
    assert(f(("eqe-;ew22")).equals(("neqe-;ew22")));
    }

}
