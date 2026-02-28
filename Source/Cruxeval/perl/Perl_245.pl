# 
sub f {
    my($alphabet, $s) = @_;
    my @a = grep { index(uc($s), $_) != -1 } split('', $alphabet);
    if ($s eq uc($s)) {
        push @a, 'all_uppercased';
    }
    return \@a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abcdefghijklmnopqrstuvwxyz", "uppercased # % ^ @ ! vz."),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
