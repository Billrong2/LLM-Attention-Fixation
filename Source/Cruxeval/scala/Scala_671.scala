import scala.math._
import scala.collection.mutable._
object Problem {
    def f(text : String, char1 : String, char2 : String) : String = {
        val t1a = new ArrayBuffer[Char]()
        val t2a = new ArrayBuffer[Char]()
        for (i <- 0 until char1.length) {
            t1a += char1(i)
            t2a += char2(i)
        }
        val t1 = text.map(c => t1a.indexOf(c) match {
            case -1 => c
            case index => t2a(index)
        }).mkString
        return t1
    }
    def main(args: Array[String]) = {
    assert(f(("ewriyat emf rwto segya"), ("tey"), ("dgo")).equals(("gwrioad gmf rwdo sggoa")));
    }

}
