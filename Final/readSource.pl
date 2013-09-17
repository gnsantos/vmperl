#!/usr/bin/perl

#Exercicio Programa I - Batalha de Robos
#MAC0242 - Laboratorio de Programacao II
#Professor Marco Dimas Gubitoso

#Fellipe Souto Sampaio 
#Número USP: 7990422 e-mail: fellipe.sampaio@usp.com

#Gervásio Protásio dos Santos Neto 
#Número USP: 7990996 e-mail: gervasio.neto@usp.br

#Vinícius Jorge Vendramini
#Número USP: 7991103 e-mail: vinicius.vendramini@usp.br

#IME-USP
#2 semestre 2013


use v5.10;
use strict;
use stack;
use operation;

#label e um marcador no codigo do programa
#opcode e o simbolo da instrucao
#arg e o argumento da operacao
#auxiliar e um escalar utilizado para permitir adiquirir o que se precisa de forma mais facil
#ref e um escalar que guarda uma referencia anonima para um vetor com (opcode,arg)
#program e um vetor que guarda as instrucoes a serem executadas e seus respectivos argumentos

my $label, my $opcode, my $arg, my $pc, my $auxiliar;
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
	    $pc = @program; #pega a quantidade de instruçoes inseridas
	    $stack->insertLabel($label,$pc); #insere no hashing a key label e o valor será a posicao do saltao
	    #dentro do vetor de instrucoes
	}

	else{
	    if(/(\b[a-zA-Z]*\b:\s*)?(\b[a-zA-Z]{2,4}\b[^:]?)(\w*)\s*[\n\f#]*/){ #identifica uma linha que pode ou 
	    	#nao conter uma label, e que contem um comando, e pode ou nao conter um arg
			$auxiliar = $2; #copia o comando lido para auxiliar para presevar integridade
			$arg = $3; #passa o argumento para arg
			($label) = $1 =~ /[a-zA-Z]+/g; #passa a label sem os : e sem espaco para $label
			($opcode) = $auxiliar =~ /[a-zA-Z]{2,4}/g; #passa o nome do comando para opcode
			$ref = [$opcode,$arg]; #cria uma referencia anonima para (opcode,arg)
			push @program, $ref; #insere o par ordenado no vetor-programa
			if(defined($label)){#se a label estiver definida tera como conteudo a posicao i do vetor Ii de instrucao.
	    		$stack->insertLabel($label,@program - 1);
			}
	    }
	}
    }
}

while($stack->retPC < @program){
    $stack->makeOperation($program[$stack->retPC]->[0], $program[$stack->retPC]->[1]);
    #traceExec($stack,$program[$stack->retPC]->[0], $program[$stack->retPC]->[1]);
    $stack->nextInstruction();
    if ($program[$stack->retPC]->[0] eq 'END'){
    	last;
    }
}
#pode ajudar na correcao, imprime a pilha e o vetor de dados a cada instrucao executada.
#se quiser utilizar basta descomentar a chamada acima (linha 54) .
sub traceExec{
	my $self = shift;
	my $opt = shift;
	my $arg = shift;
    print ("($opt X $arg)\n");
	$stack->printaStack();
    $stack->printaMem();
     print "\n-----------------------\n";
}
