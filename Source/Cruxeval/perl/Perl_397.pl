# 
sub f {
    my($ls) = @_;
    return { map { $_ => 0 } @$ls };
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["x", "u", "w", "j", "3", "6"]),{"x" => 0, "u" => 0, "w" => 0, "j" => 0, "3" => 0, "6" => 0})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
