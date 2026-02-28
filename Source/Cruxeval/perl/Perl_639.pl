# 
sub f {
    my($perc, $full) = @_;
    my $reply = "";
    my $i = 0;
    while (substr($perc, $i, 1) eq substr($full, $i, 1) && $i < length($full) && $i < length($perc)) {
        if (substr($perc, $i, 1) eq substr($full, $i, 1)) {
            $reply .= "yes ";
        } else {
            $reply .= "no ";
        }
        $i++;
    }
    return $reply;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("xabxfiwoexahxaxbxs", "xbabcabccb"),"yes ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
