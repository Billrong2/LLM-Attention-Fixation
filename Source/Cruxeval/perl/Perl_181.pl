# 
sub f {
    my($s) = @_;
    my $count = 0;
    my $digits = "";
    foreach my $c (split //, $s) {
        if ($c =~ /\d/) {
            $count++;
            $digits .= $c;
        }
    }
    return [$digits, $count];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("qwfasgahh329kn12a23"),["3291223", 7])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
