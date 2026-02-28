sub f {
    my($text, $width) = @_;
    my $new_text = substr($text, 0, $width);
    return substr("zzz${new_text}zzz", 0, $width);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("0574", 9),"zzz0574zz")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
