# 
sub f {
    my($address) = @_;
    my $suffix_start = index($address, '@') + 1;
    if (substr($address, $suffix_start) =~ tr/././ > 1) {
        my @split_address = split('@', $address);
        my @suffix_parts = split('.', $split_address[1]);
        splice @suffix_parts, 2;
        $address = $split_address[0] . '@' . join('.', @suffix_parts);
    }
    return $address;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("minimc@minimc.io"),"minimc@minimc.io")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
