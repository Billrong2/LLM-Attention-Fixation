# 
sub f {
    my($container, $cron) = @_;
    my @container = @{$container};
    if (!grep { $_ eq $cron } @container) {
        return $container;
    }
    
    my @pref = @container[0..(first_index { $_ eq $cron } @container)-1];
    my @suff = @container[(first_index { $_ eq $cron } @container)+1..$#container];
    
    return [@pref, @suff];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([], 2),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
