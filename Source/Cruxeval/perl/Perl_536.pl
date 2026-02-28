# 
sub f {
    my($cat) = @_;
    my $digits = 0;
    foreach my $char (split //, $cat) {
        if ($char =~ /\d/) {
            $digits++;
        }
    }
    return $digits;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("C24Bxxx982ab"),5)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
