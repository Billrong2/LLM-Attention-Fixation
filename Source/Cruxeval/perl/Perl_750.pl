# 
sub f {
    my($char_map, $text) = @_;
    my $new_text = '';
    foreach my $ch (split('', $text)) {
        my $val = $char_map->{$ch};
        if (!defined($val)) {
            $new_text .= $ch;
        } else {
            $new_text .= $val;
        }
    }
    return $new_text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}, "hbd"),"hbd")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
