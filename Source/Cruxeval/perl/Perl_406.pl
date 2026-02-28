# 
sub f {
    my($text) = @_;
    my @ls = split //, $text;
    @ls[0, -1] = map { uc $_ } @ls[0, -1];
    return join('', @ls) ~~ /^(\p{Lu}{1}\p{Ll}*)$/;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Josh"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
