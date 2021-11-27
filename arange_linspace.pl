use strict;
use warnings;
use Clone qw(clone);#cpan Clone
use Data::Dump qw(dump);
sub arange{
 my ($start, $stop, $step) = @_;
 if (scalar(@_)==1) {
   $stop = $start;
   return map{$_} 0..$stop-1;
 }
 elsif (scalar(@_)==2){
   return map{$_} $start..$stop-1;
 }
 elsif (scalar(@_)==3){
   my $i = $start-$step;
   return map{$i+=$step} (1..(($stop-$start-1)/$step)+1);
 }else {print "Wrong arguments";}
}

sub linspace{
   my ($start, $stop, $num, $endpoint, $retstep) = @_;
   my $step = 0;
   
   if (scalar(@_)==3){
     return case3(@_,[]);  
   } elsif(scalar(@_)==4 || scalar(@_)==5){
      if ($endpoint eq "true" || $endpoint eq "True" || $endpoint eq "TRUE") {        
        $step = ($stop - $start)/$num;
        $start -= $step;
        if (defined $retstep && ($retstep eq "true"|| $retstep eq "True" || $retstep eq "TRUE")){
          print $step, ", ";
        } 
        return map {$start+=$step}0..$num-1;
     } else {
        return case3(@_,[]);}     
   }
     
   sub case3{
     my ($start, $stop, $num, $endpoint, $retstep) = @_;
     my $step = 0;
     $step = ($stop - $start)/($num-1);
     $start -= $step;
     if (defined $retstep && ($retstep eq "true"|| $retstep eq "True" || $retstep eq "TRUE")) {
        print $step, ", " ;
     } 
     return map {$start+=$step}1..$num;     
   }
}
my @arr1 = arange(5,20,3);
my @arr2 = linspace(2.0,3.0,5,'FALSO','TRUE');
#p(@arr1);
#p(@arr2);
