BEGIN {
	FS=","
}

/GPGGA/ {
	printf( "GPGGA,%f,%f,%f,%f\n", $2, $3, $5, $10 * 3.28084 ) 
	fflush("/dev/stdout")
	#system( "" )
}

