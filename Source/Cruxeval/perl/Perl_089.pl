# 
sub f {
    my($char) = @_;
    if ($char !~ /[aeiouAEIOU]/) {
        return undef;
    }
    if ($char =~ /[AEIOU]/) {
        return lc($char);
    }
    return uc($char);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("o"),"O")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
