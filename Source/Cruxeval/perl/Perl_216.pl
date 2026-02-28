# 
sub f {
    my($letters) = @_;
    my $count = 0;
    foreach my $l (split(//, $letters)) {
        if ($l =~ /\d/) {
            $count++;
        }
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("dp ef1 gh2"),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
