import scala.math._
import scala.collection.mutable._
object Problem {
    def f(ip : String, n : Long) : String = {
        var i = 0
        var out = ""
        for (c <- ip) {
            if (i == n) {
                out += "\n"
                i = 0
            }
            i += 1
            out += c
        }
        out
    }
    def main(args: Array[String]) = {
    assert(f(("dskjs hjcdjnxhjicnn"), (4l)).equals(("dskj\ns hj\ncdjn\nxhji\ncnn")));
    }

}
