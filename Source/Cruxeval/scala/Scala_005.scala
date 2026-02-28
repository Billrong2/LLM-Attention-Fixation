import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, lower : String, upper : String) : Tuple2[Long, String] = {
        var count = 0l
        var new_text = new ListBuffer[String]()
        for (char <- text) {
            var char2 = if (char.isDigit) lower else upper
            if (List("p", "C").contains(char2)) {
                count += 1
            }
            new_text += char2
        }
        (count, new_text.mkString(""))
    }
    def main(args: Array[String]) = {
    assert(f(("DSUWeqExTQdCMGpqur"), ("a"), ("x")).equals(((0l, "xxxxxxxxxxxxxxxxxx"))));
    }

}
