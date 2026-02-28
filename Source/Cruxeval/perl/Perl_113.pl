# 
sub f {
    my($line) = @_;
    my @a = ();
    my $count = 0;
    for my $i (0..length($line)-1) {
        $count += 1;
        my $char = substr $line, $i, 1;
        if ($count%2==0) {
            $char =~ tr/a-zA-Z/A-Za-z/;
        }
        push @a, $char;
    }
    return join('', @a);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("987yhNSHAshd 93275yrgSgbgSshfbsfB"),"987YhnShAShD 93275yRgsgBgssHfBsFB")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
