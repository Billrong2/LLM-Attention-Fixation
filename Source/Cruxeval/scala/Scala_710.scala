import scala.math._
import scala.collection.mutable._
object Problem {
    def f(playlist : Map[String,List[String]], liker_name : String, song_index : String) : Map[String,List[String]] = {
        var updatedPlaylist = playlist + (liker_name -> (playlist.getOrElse(liker_name, List()) :+ song_index))
        updatedPlaylist
    }
    def main(args: Array[String]) = {
    assert(f((Map[String,List[String]]("aki" -> List[String]("1", "5"))), ("aki"), ("2")).equals((Map[String,List[String]]("aki" -> List[String]("1", "5", "2")))));
    }

}
