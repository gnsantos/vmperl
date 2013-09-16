#!/usr/bin/perl

use v5.10;
use strict;
use stack;
use operation;

#label e um marcador no codigo do programa
#opcode e o simbolo da instrucao
#arg e o argumento da operacao
#auxiliar e um escalar utilizado para permitir adiquirir o que se precisa de forma mais facil
#labelHash e um hash que mantem registro das labels que ja apareceram
#ref e um escalar que guarda uma referencia anonima para um vetor com (opcode,arg)
#program e um vetor que guarda as instrucoes a serem executadas e seus respectivos argumentos

my $label, my $opcode, my $arg, my $pc, my $auxiliar;
my %labelHash;
my @program, my $ref;
$, = " ";

our $stack = new stack();
while(<>){
    chomp($_);
    
    if(/^#.*[\n\f]*/){
	print "";
    }

    else{
	if(/(\b[a-zA-Z]*\b:\s*)[\n\f#]*$/){ #linha contendo apenas uma label
	    ($label) = $1 =~ /[a-zA-Z]+/g; #retira o : do nome da label
	    $pc = @program; # A label esta referenciando a instrucao #(@programa)
	    $stack->insertLabel($label,$pc);

	    # print "Label : $label // pos : $pc \n";
	    #$labelHash{$label} = $pc; usa a label como key de um hash. O valor armazenado 
	    #e a posicao no programa em que aparece o codigo a ser executado
	}

	else{
	    if(/(\b[a-zA-Z]*\b:\s*)?(\b[a-zA-Z]{2,4}\b[^:]?)(\w*)\s*[\n\f#]*/){ #identifica uma linha que pode ou nao conter uma label, e que contem um comando, e pode ou nao conter um arg
			$auxiliar = $2; #copia o comando lido para auxiliar para presevar integridade
			$arg = $3; #passa o argumento para arg
			($label) = $1 =~ /[a-zA-Z]+/g; #passa a label sem os : e sem espaco para $label
			($opcode) = $auxiliar =~ /[a-zA-Z]{2,4}/g; #passa o nome do comando para opcode
			$ref = [$opcode,$arg]; #cria uma referencia anonima para (opcode,arg)
			#print "($opcode -- $arg) \n";
			push @program, $ref; #insere o par ordenado no vetor-programa
			if(defined($label)){
	    		$stack->insertLabel($label,@program - 1);
	    		# print "XX Label : $label // pos : $quick \n";
			    #$labelHash{$label} = @program - 1; caso a label exista, insere-a no hash
			}
	    }
	}
    }
}


#$stack->newOpt();

# my $k = $stack->retPC();

# print "Valor do x = $k \n";

# $stack->nextInstruction();
# $stack->nextInstruction();
# $stack->nextInstruction();
# $stack->nextInstruction();
# $stack->nextInstruction();

# $k = $stack->retPC();
# print "Valor do x = $k \n";


# $stack->makeOperation('PUSH',10);
# $stack->makeOperation('PUSH',11);
# $stack->makeOperation('PUSH',5);
# $stack->makeOperation('PUSH',5);
# $stack->printaStack();

# $stack->makeOperation('JIT',13);

# $k = $stack->retPC();

# print "Valor do x = $k \n";

# $stack->makeOperation('EQ',undef);

# $stack->printaStack();

# $stack->makeOperation('JMP',14);
# $k = $stack->retPC();
# print "Valor do x = $k \n";

# $stack->makeOperation('PUSH',0);
# $stack->makeOperation('PUSH',11);
# $stack->makeOperation('PUSH',12);
# $stack->makeOperation('PUSH',13);
# $stack->makeOperation('PUSH',14);
# $stack->makeOperation('PUSH',0);
# $stack->printaStack();
# $stack->makeOperation('POP',undef);
# $stack->makeOperation('POP',undef);
# $stack->makeOperation('POP',undef);
# $stack->makeOperation('POP',undef);
# $stack->makeOperation('POP',undef);
# $stack->makeOperation('POP',undef);
# $stack->makeOperation('POP',undef);
# $stack->printaStack();

while($stack->retPC < @program){
    #print "$program[$stack->retPC]->[0]\n";
    # $stack->printaStack();
    # print "\nxxxx\n";
    # print ("($program[$stack->retPC]->[0] X $program[$stack->retPC]->[1])\n");
    $stack->makeOperation($program[$stack->retPC]->[0], $program[$stack->retPC]->[1]);
    # $stack->printaStack();
    # $stack->printaMem();
    # print "\n-----------------------\n";
    $stack->nextInstruction();
}
