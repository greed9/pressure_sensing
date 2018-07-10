BEGIN {
	FS=","
	count = 0
	pushCmd = "curl -F 'value=%f' -F 'lat=%f' -F 'lon=%f' -F 'ele=%f' -H \"X-AIO-Key: 6ae53a0570984238b46888bc806285fc\" \
  https://io.adafruit.com/api/v2/SnoozeCat/feeds/pressure-altitude/data"
	bme280Cmd = "python /home/pi/Adafruit_Python_GPIO/Adafruit_Python_BME280/Adafruit_BME280_Example.py"
}

/GPGGA/ {
	count ++
	if( count > 0 ) {
		pressure  = 0
		cmd = ""

		# gawk idiom to shell a command and catch result
       		bme280Cmd | getline pressure
       		close(bme280Cmd)
		printf ( "\n%f\n", pressure )

		# Pressure to altitude conversion from Wikipedia
		altitude = 145366.45 * ( 1.0 - ( ( pressure / 1013.25 ) ^ 0.190284 ) )

		# NEMA GPS lat/lon to decimal degrees, from Stack Overflow
		# lat first.  NEMA is ddmm.mmmm
		deg = substr( $3, 1,  2) * 1.0
		min = substr( $3, 3,  7) * 1.0
		lat = deg + ( min / 60.0 )
		if( $4 == "S") {
			lat = lat * -1.0
		}

		# Now long, NEMA is dddmm.mmmm
		deg = substr( $5, 1, 3 ) * 1.0
		min = substr( $5, 4, 7 ) * 1.0
		lon = deg + ( min / 60.0 )
		if( $6 == "W") {
			lon = lon * -1.0
		}

		# Push pressure altitude, lat, lon, and gps elevation (converted from meters to feet)
		cmd = sprintf( pushCmd, altitude, lat, lon, $10 * 3.28084 )
		printf ( "\n%s\n", cmd )
		#system( cmd )
		#print pushCmd
		#fflush( "/dev/stdout")
		count = 0
	}
}

