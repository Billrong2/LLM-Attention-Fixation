# 
sub f {
    my($text) = @_;
    my $b = 'True';
    for my $x (split //, $text) {
        if ($x =~ /\d/) {
            $b = 'True';
        } else {
            $b = 'False';
            last;
        }
    }
    return $b eq 'True';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("-1-3"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
