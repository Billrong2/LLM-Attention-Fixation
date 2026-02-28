# 
sub f {
    my($s) = @_;
    my $nums = join('', grep { $_ =~ /^\d+$/ } split('', $s));
    if ($nums eq '') {
        return 'none';
    }
    my @num_list = split(',', $nums);
    my $m = (sort { $b <=> $a } map { int($_) } @num_list)[0];
    return "$m";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("01,001"),"1001")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
