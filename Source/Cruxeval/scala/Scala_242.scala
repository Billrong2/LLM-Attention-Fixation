import scala.math._
import scala.collection.mutable._
object Problem {
    def f(book : String) : String = {
        val a = book.split(":").last.split(" ")
        if (book.split(" ").last == a.head)
            return f(book.split(" ").dropRight(1).mkString(" ") + " " + a.mkString(" "))
        book
    }
    def main(args: Array[String]) = {
    assert(f(("udhv zcvi nhtnfyd :erwuyawa pun")).equals(("udhv zcvi nhtnfyd :erwuyawa pun")));
    }

}
