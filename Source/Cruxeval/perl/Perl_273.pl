# 
sub f {
    my($name) = @_;
    my $new_name = '';
    $name = reverse($name);
    for my $i (0..length($name)-1) {
        my $n = substr($name, $i, 1);
        if ($n ne '.' && $new_name =~ tr/././ < 2) {
            $new_name = $n . $new_name;
        } else {
            last;
        }
    }
    return $new_name;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(".NET"),"NET")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
