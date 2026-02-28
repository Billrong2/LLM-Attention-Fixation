# 
sub f {
    my($txt, $alpha) = @_;
    my @txt = sort @$txt;
    if((grep { $txt[$_] eq $alpha } 0..$#txt)[0] % 2 == 0) {
      return [reverse @txt];
    }
    return \@txt;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["8", "9", "7", "4", "3", "2"], "9"),["2", "3", "4", "7", "8", "9"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
