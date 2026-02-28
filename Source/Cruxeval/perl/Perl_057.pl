# 
sub f {
    my($text) = @_;
    $text = uc($text);
    my $count_upper = 0;
    foreach my $char (split(//, $text)) {
        if (uc($char) eq $char) {
            $count_upper++;
        } else {
            return 'no';
        }
    }
    return int($count_upper / 2);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ax"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
