# 
sub f {
    my($d) = @_;
    my $i = each %$d;
    return ($i->[0], $i->[1]), (each %$d)[0, 1];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"a" => 123, "b" => 456, "c" => 789}),[["a", 123], ["b", 456]])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
