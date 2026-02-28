# 
sub f {
    my($playlist, $liker_name, $song_index) = @_;
    $playlist->{$liker_name} = $playlist->{$liker_name} // [];
    push(@{$playlist->{$liker_name}}, $song_index);
    return $playlist;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"aki" => ["1", "5"]}, "aki", "2"),{"aki" => ["1", "5", "2"]})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
