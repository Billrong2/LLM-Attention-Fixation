# 
sub f {
    my($text) = @_;
    my ($k, $l) = (0, length($text) - 1);
    while ($text =~ m/^[^a-zA-Z]/ && $l >= 0) {
        $l--;
    }
    while ($text =~ m/[^a-zA-Z]$/ && $k < length($text)) {
        $k++;
    }
    if ($k != 0 || $l != length($text) - 1) {
        return substr($text, $k, $l - $k + 1);
    } else {
        return substr($text, 0, 1);
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("timetable, 2mil"),"t")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
