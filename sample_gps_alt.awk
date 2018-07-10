BEGIN {
	FS=","
	count = 0
	pushCmd = "curl -F 'value=%f' -F 'lat=%f' -F 'lon=%f' -F 'ele=%f' -H \"X-AIO-Key: 6ae53a0570984238b46888bc806285fc\" \
  https://io.adafruit.com/api/v2/SnoozeCat/feeds/pressure-altitude/data"
	bme280Cmd = "python /home/pi/Adafruit_Python_GPIO/Adafruit_Python_BME280/Adafruit_BME280_Example.py"
}

/GPGGA/ {
	count ++
	if( count > 14 ) {
		pressure  = 0
		cmd = ""
       		bme280Cmd | getline pressure
       		close(bme280Cmd)
		printf ( "\n%f\n", pressure )
		cmd = sprintf( pushCmd, pressure, $3, $5, $10 * 3.28084 )
		printf ( "\n%s\n", cmd )
		system( cmd )
		#print pushCmd
		#fflush( "/dev/stdout")
		count = 0
	}
	#printf( "GPGGA,%f,%f,%f,%f\n", $2, $3, $5, $10 * 3.28084 )
	#fflush("/dev/stdout")
	#system( "" )
}

