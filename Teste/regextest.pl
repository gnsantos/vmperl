#!/usr/bin/perl

while(<>){
    if(/([A-Z]*:\s*)?(\b[A-Z]{3,4}\b[^:]?)(\w*)\s*[\n\f#]+/){
	print "Argumentos: ";
	print $1." ".$2." ".$3."\n";
    }
    else{
	if(/^#.*[\n\f]+/){
	    print "Linha de comentario.\n";
	}
	else{
	    if(/([A-Z]*:\s*)[\n\f]+/){
		print "Linha so com nome do laço. TAG = ".$1."\n";
	    }
	}
    }

    
}
