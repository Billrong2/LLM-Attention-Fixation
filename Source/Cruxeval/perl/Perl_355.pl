# 
sub f {
    my($text, $prefix) = @_;
    return substr($text, length($prefix));
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("123x John z", "z"),"23x John z")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
