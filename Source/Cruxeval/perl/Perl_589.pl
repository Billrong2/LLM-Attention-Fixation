# 
sub f {
    my($num) = @_;
    push @{$num}, $num->[-1];
    return $num;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-70, 20, 9, 1]),[-70, 20, 9, 1, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
