# 
sub f {
    my($dictionary) = @_;
    $dictionary->{1049} = 55;
    my($key, $value) = each %$dictionary;
    delete $dictionary->{$key};
    $dictionary->{$key} = $value;
    return $dictionary;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"noeohqhk" => 623}),{"noeohqhk" => 623, "1049" => 55})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
