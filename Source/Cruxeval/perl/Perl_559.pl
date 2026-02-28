# 
sub f {
    my($n) = @_;
    $n = "$n";
    return substr($n, 0, 1) . '.' . substr($n, 1, length($n)-1) =~ s/-/_/gr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("first-second-third"),"f.irst_second_third")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
