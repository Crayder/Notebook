# Sphere and cosine directionals.

    public OnRconCommand(cmd[])
    {
    	new cmdname[24], Float:Radius, Float:lat, Float:lon;
    	if(!sscanf(cmd, "s[24]fff", cmdname, Radius, lat, lon)) {
    		if(!strcmp(cmdname, "set")) {
    			new Float:LAT = lat * floatpi/180.0,
    				Float:LON = lon * floatpi/180.0,
    				Float:x = -Radius * floatcos(LAT) * floatcos(LON),
    				Float:y = Radius * floatcos(LAT) * floatsin(LON),
    				Float:z = Radius * floatsin(LAT);
    			
    			printf("[%3.3f, %3.3f] %4.4f, %4.4f, %4.4f | %4.4f, %4.4f, %4.4f", LAT, LON, x, y, z, acos(x/Radius), acos(y/Radius), acos(z/Radius));
    		}
    	}
    	return 1;
    }