import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, wrong : String, right : String) : String = {
        val new_text = text.replace(wrong, right)
        return new_text.toUpperCase
    }
    def main(args: Array[String]) = {
    assert(f(("zn kgd jw lnt"), ("h"), ("u")).equals(("ZN KGD JW LNT")));
    }

}
