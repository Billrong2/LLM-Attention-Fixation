import scala.math._
import scala.collection.mutable._
object Problem {
    def f(student_marks : Map[String,Long], name : String) : Any = {
        if (student_marks.contains(name)) {
            val value = student_marks(name)
            student_marks-=name
            value
        } else {
            "Name unknown"
        }
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,Long]("882afmfp" -> 56l)), ("6f53p")).equals("Name unknown"));
    }

}
