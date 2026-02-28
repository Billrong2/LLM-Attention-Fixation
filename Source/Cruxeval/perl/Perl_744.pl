# 
sub f {
    my($text, $new_ending) = @_;
    my @result = split(//, $text);
    push @result, split(//, $new_ending);
    return join('', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("jro", "wdlp"),"jrowdlp")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
