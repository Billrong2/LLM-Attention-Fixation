import scala.math._
import scala.collection.mutable._
object Problem {
    def f(container : List[Long], cron : Long) : List[Long] = {
        if (!container.contains(cron)) {
            return container
        }
        val pref = container.slice(0, container.indexOf(cron)).toList
        val suff = container.slice(container.indexOf(cron) + 1, container.size).toList
        pref ::: suff
    }
    def main(args: Array[String]) = {
    assert(f((List[Long]()), (2l)).equals((List[Long]())));
    }

}
