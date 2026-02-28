# 
sub f {
    my($a, $b) = @_;
    return { %$a, %$b };
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"w" => 5, "wi" => 10}, {"w" => 3}),{"w" => 3, "wi" => 10})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
