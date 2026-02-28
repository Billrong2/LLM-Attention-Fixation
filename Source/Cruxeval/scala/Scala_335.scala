import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, to_remove : String) : String = {
        var new_text = text.toList
        if (new_text.contains(to_remove.head)) {
            val index = new_text.indexOf(to_remove.head)
            new_text = new_text.patch(index, List('?'), 1)
            new_text = new_text.patch(new_text.indexOf('?'), Nil, 1)
        }
        new_text.mkString("")
    }
    def main(args: Array[String]) = {
    assert(f(("sjbrlfqmw"), ("l")).equals(("sjbrfqmw")));
    }

}
