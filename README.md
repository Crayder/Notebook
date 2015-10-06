# Sphere and cosine directionals (Incomplete).
## Returns a point on a sphere give latitude and longitude angles. Also returns the cosine directionals needed to 'point' to the center.

    public OnRconCommand(cmd[])
    {
    	new cmdname[24], Float:Radius, Float:lat, Float:lon;
    	if(!sscanf(cmd, "s[24]fff", cmdname, Radius, lat, lon)) {
    		if(!strcmp(cmdname, "set")) {			
    			new	Float:x = Radius * floatcos(lat, degrees) * floatcos(lon, degrees),
    				Float:y = Radius * floatcos(lat, degrees) * floatsin(lon, degrees),
    				Float:z = Radius * floatsin(lat, degrees);
    			
    			printf("[%3.3f, %3.3f] %4.4f, %4.4f, %4.4f | %4.4f, %4.4f, %4.4f", lat, lon, x, y, z, 180.0 * x, 180.0 * y, -lat);
    		}
    	}
    	return 1;
    }
