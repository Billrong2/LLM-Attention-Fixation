# 
sub f {
    my($num, $name) = @_;
    return "quiz leader = $name, count = $num";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(23, "Cornareti"),"quiz leader = Cornareti, count = 23")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
