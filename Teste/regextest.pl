#!/usr/bin/perl

while(<>){
    if(/([A-Z]*:\s*)?(\b[A-Z]{3,4}\b[^:]?)(\w*)\s*[\n\f#]+/){
	print "Argumentos: ";
	print $1." ".$2." ".$3."\n";
    }
    else{print "Syntax Error.\n";}
}
