import scala.math._
import scala.collection.mutable._

object Problem {
    def swapCaseChar(c: Char): Char = {
        if (c.isUpper) c.toLower else c.toUpper
    }

    def f(text : String) : String = {
        val textList = text.toList
        val new_text = textList.zipWithIndex.map { case (c, i) => if (i % 2 == 1) swapCaseChar(c) else c }
        new_text.mkString("")
    }

    def check(candidate: String => String): Unit = {
        assert(candidate("example") == "eXaMpLe")
    }

    def test_check(): Unit = {
        check(f)
    }
    def main(args: Array[String]) = {
    assert(f(("Hey DUdE THis $nd^ &*&this@#")).equals(("HEy Dude tHIs $Nd^ &*&tHiS@#")));
    }

}
