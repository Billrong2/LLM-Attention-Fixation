import scala.math._
import scala.collection.mutable._
object Problem {
    def f(s1 : String, s2 : String) : List[Long] = {
        var res: ListBuffer[Long] = ListBuffer()
        var i = s1.lastIndexOf(s2)
        while (i != -1) {
            res += i + s2.length - 1
            i = s1.lastIndexOf(s2, i - 1)
        }
        res.toList
    }
    def main(args: Array[String]) = {
    assert(f(("abcdefghabc"), ("abc")).equals((List[Long](10l.toLong, 2l.toLong))));
    }

}
