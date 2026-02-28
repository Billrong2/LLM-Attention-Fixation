# 
sub f {
    my($dictionary, $key) = @_;
    delete $dictionary->{$key};
    if ($key eq (sort keys %$dictionary)[0]) {
        $key = (keys %$dictionary)[0];
    }
    return $key;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"Iron Man" => 4, "Captain America" => 3, "Black Panther" => 0, "Thor" => 1, "Ant-Man" => 6}, "Iron Man"),"Iron Man")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
