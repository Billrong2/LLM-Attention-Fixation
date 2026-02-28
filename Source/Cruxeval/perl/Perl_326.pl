# 
sub f {
    my($text) = @_;
    my $number = 0;
    foreach my $t (split //, $text) {
        if ($t =~ /\d/) {
            $number++;
        }
    }
    return $number;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Thisisastring"),0)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
