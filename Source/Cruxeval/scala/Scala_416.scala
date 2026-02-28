import scala.collection.mutable._
import scala.math._
object Problem {
    def f(text: String, old: String, newStr: String): String = {
        var index = text.lastIndexOf(old, text.indexOf(old))
        var result = text.toArray
        while (index > 0) {
            result.update(index, newStr.charAt(0))
            for (i <- index + 1 until index + old.length) {
                result(i) = ' '
            }
            index = text.lastIndexOf(old, 0, index)
        }
        result.mkString
    }
    def main(args: Array[String]) = {
    assert(f(("jysrhfm ojwesf xgwwdyr dlrul ymba bpq"), ("j"), ("1")).equals(("jysrhfm ojwesf xgwwdyr dlrul ymba bpq")));
    }

}
