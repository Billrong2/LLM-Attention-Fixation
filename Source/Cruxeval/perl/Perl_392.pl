# 
sub f {
    my($text) = @_;
    if (uc($text) eq $text) {
        return 'ALL UPPERCASE';
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Hello Is It MyClass"),"Hello Is It MyClass")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
