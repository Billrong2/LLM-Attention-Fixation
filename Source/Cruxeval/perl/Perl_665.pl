# 
sub f {
    my ($chars) = @_;
    my $s = '';
    foreach my $ch (split //, $chars) {
        my $count = () = $chars =~ /\Q$ch\E/g;
        if ($count % 2 == 0) {
            $s .= uc($ch);
        } else {
            $s .= $ch;
        }
    }
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("acbced"),"aCbCed")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
