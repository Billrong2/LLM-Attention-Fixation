# 
sub f {
    my($d) = @_;
    return { %$d };
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"a" => 42, "b" => 1337, "c" => -1, "d" => 5}),{"a" => 42, "b" => 1337, "c" => -1, "d" => 5})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
