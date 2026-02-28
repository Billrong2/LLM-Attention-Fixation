import scala.math._
object Problem {
    def f(text : String) : String = {
        val l = text.lastIndexOf('0')
        if (l == -1) {
            return "-1:-1"
        } else {
            return f"${l}%d:${text.substring(l + 1).indexOf('0') + 1}%d"
        }
    }
    def main(args: Array[String]) = {
    assert(f(("qq0tt")).equals(("2:0")));
    }

}
