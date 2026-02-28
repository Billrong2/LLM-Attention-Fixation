# 
sub f {
    my($text, $old, $new) = @_;
    my $index = rindex($text, $old, index($text, $old));
    my @result = split('', $text);
    while ($index > 0) {
        splice(@result, $index, length($old), $new);
        $index = rindex($text, $old, $index);
    }
    return join('', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("jysrhfm ojwesf xgwwdyr dlrul ymba bpq", "j", "1"),"jysrhfm ojwesf xgwwdyr dlrul ymba bpq")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
