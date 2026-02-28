import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String) : Long = {
        var m = 0
        var cnt = 0
        text.split(" ").foreach { i =>
            if (i.length > m) {
                cnt += 1
                m = i.length
            }
        }
        cnt
    }
    def main(args: Array[String]) = {
    assert(f(("wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl")) == (2l));
    }

}
