# 
sub f {
    my($text) = @_;
    my @result;
    for(my $i = 0; $i < length($text); $i++) {
        if(ord(substr($text, $i, 1)) > 127) {
            return 0;
        } elsif($text =~ /\w/) {
            push @result, uc(substr($text, $i, 1));
        } else {
            push @result, substr($text, $i, 1);
        }
    }
    return join('', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ua6hajq"),"UA6HAJQ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
