use warnings;
use strict;
use GD::Graph::points;
use Data::Dump qw(dump);
use GD::Graph::colour;
use Chart::Gnuplot;
#use Math::BigFloat ':constant';
my @data = (
        [5,2,0],
        [2,4,0],
        [2,5,1],
        [4,6,1],
        [5,2,1],
        [1,5,1],
        [6,7,0],
        [4,2,0],
        [6,4,0],
        [9,2,0],
        [4,5,1],
        [1,6,1],
        [4,7,0],
        [3,6,0],
        [1,1,0],
        [8,4,1],
        [8,7,1],
        [7,2,1],
        [2,2,0],
        [2,1,0],
        [1,2,0],
        [1,4,1],
        [2,6,1],
        [7,7,0],
        [7,4,0],
        [3,4,1],
        [1,4,1],
        
        );

    my @x = map $_->[0], @data;# ($_->) con esto estoy tomando un unico valor,q  corresponderia al primer elementeo de la fila
    my @y = map $_->[1], @data;
    my @label = map $_->[2], @data;
  
    
my @l_zeros= map{
    if ($_ ->[2] == 0) {
        $_ ->[1];
    }
    }@data;
my @l_unos= map{
    if ($_ ->[2] == 1) {
        $_ ->[1];
    }
    }@data;


#my @y = [i[1] for i in data];
#my @label = [i[2] for i in data];
#voy a definir el tamanio de la ventana
#definir titulo, escala de los ejes
my $graph = new GD::Graph::points(900, 600);
$graph->set( 
    x_label           => 'X Label',
    y_label           => 'Y label',
    title             => 'Algoritmo KNN',
    x_tick_number     => 10,
    y_tick_number     => 10,
    x_min_value     =>0,
    x_max_value   =>10,
    y_min_value     => 0,
    y_max_value   =>10,
    dclrs => [ qw(pink green) ]
  
) or die $graph->error;

my $gd = $graph->plot([\@x,\@l_zeros,\@l_unos]) or die $graph->error;
open(IMG, '>knnprueba.png') or die $!;
binmode IMG;
print IMG $gd->png;

print IMG $graph->plot([\@x,\@l_zeros,\@l_unos])->png;



#crear la funcion distancia
sub distancia{
    my ($testRow, $trainRow)=@_;

    my $d=0.0;
    for(my $i=0; $i<@{$trainRow}-1; $i++){ # en esta parte quitamos el ultimo elemento, solo recorre hasta el segundo
        $d += (@{$testRow}[$i]-@{$trainRow}[$i])**2;
        
    }
    return $d=($d)**(1/2);
}

#print distancia([1,2,0],[5,1,1]);
#vamos a pedir al usuario que ingrese los da tos de prueba
my @test_entrada = ();
print "\nIngrese el valor de x: ";
$test_entrada[0]=<STDIN>;
print "Ingrese el valor de y: ";
$test_entrada[1]=<STDIN>;
print "Ingrese el valor de K: ";
my $k=<STDIN>;




#aplicar el algoritmo KNN
my @d=();
for (my $i=0;$i<@data; $i++){#@data significa que queremos conocer el tamanio del arreglo
    my $temp= distancia(\@test_entrada,$data[$i]);#$data[$i] significa que voy a acceder a cada elemento del arreglo
    push(@d,[$temp,$data[$i]]); 
}
my @dist_ordenadas = sort ({$a->[0] <=> $b->[0]} @d);
my @knn= ();
print ("K nearest neightbours \n");
for(my $i=0; $i<$k; $i++){
   print ("\npoint: (", $dist_ordenadas[$i][1][0],",",$dist_ordenadas[$i][1][1],") with distance: ", $dist_ordenadas[$i][0], " and class: ", $dist_ordenadas[$i][1][-1]);
   push(@knn,$dist_ordenadas[$i][1]); #k arreglo y cada arreglo, tiene la distancia en x, la distanci en y y la clase
}

#my @labels= ();
#for (my $i=0; $i<@knn; $i++){
#    $labels[$i]=$knn[$i][-1];
#}
#el map sirve cuando queremos recorrer todos el arreglo
my @labels= map{$_ ->[-1]} @knn; #guardando el ultimos elemento de cada fila de mi arreglo knn
my $zeros = count(\@labels, 0);
my $unos =  count(\@labels, 1);
print $zeros > $unos ? "\nLa clase es: 0" : "\nLa clase es: 1";


#crear una funcion que cuente el numero de 0s y 1s
sub count{
    my $key = $_[-1]; #tomando el ultimo elemento del arreglo de entrada
    my @array= @{$_[0]};
    my $contador=0;
    map {if ($_ == $key) {$contador++}}@array; #el $_ recorre cada fila del arreglo
    return $contador;
}

=cut
labels = [label[-1] for label in knn]
pred = max(set(labels), key=labels.count)
print('prediction: '+str(pred))


#$zeros > $unos ?  print "La clase es: 0" : print "La clase es: 1";
#if ($zeros > $unos) {
#    print "La clase es: 0";
#}else{
#    print "La clase es: 1";
#}
