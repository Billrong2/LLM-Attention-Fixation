# 
sub f {
    my($s, $separator) = @_;
    for(my $i = 0; $i < length($s); $i++) {
        if(substr($s, $i, 1) eq $separator){
            my @new_s = split('', $s);
            $new_s[$i] = '/';
            return join(' ', @new_s);
        }
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("h grateful k", " "),"h / g r a t e f u l   k")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
