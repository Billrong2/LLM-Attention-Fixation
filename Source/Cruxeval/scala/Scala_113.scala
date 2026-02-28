import scala.math._
import scala.collection.mutable._

object Problem {
    def swapCase(c: Char): Char = {
        if (c.isUpper) c.toLower else c.toUpper
    }

    def f(line : String) : String = {
        var count = 0
        var a = ListBuffer[Char]()
        for (i <- 0 until line.length){
            count += 1
            if (count%2==0){
                a += swapCase(line(i))
            } else {
                a += line(i)
            }
        }
        a.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("987yhNSHAshd 93275yrgSgbgSshfbsfB")).equals(("987YhnShAShD 93275yRgsgBgssHfBsFB")));
    }

}
