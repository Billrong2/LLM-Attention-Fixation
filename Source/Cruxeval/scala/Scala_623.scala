import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, rules : List[String]) : String = {
        var result = text
        for (rule <- rules) {
            if (rule == "@") {
                result = result.reverse
            } else if (rule == "~") {
                result = result.toUpperCase
            } else if (result.nonEmpty && result.charAt(result.length - 1) == rule.charAt(0)) {
                result = result.substring(0, result.length - 1)
            }
        }
        return result
    }
    def main(args: Array[String]) = {
    assert(f(("hi~!"), (List[String]("~", "`", "!", "&"))).equals(("HI~")));
    }

}
