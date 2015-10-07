# Sphere and cosine directionals (Incomplete).
### _Returns a point on a sphere give latitude and longitude angles. Also returns the cosine directionals needed to 'point' to the center._

```pawn
public OnRconCommand(cmd[])
{
	new cmdname[24], Float:Radius, Float:lat, Float:lon;
	if(!sscanf(cmd, "s[24]fff", cmdname, Radius, lat, lon)) {
		if(!strcmp(cmdname, "set")) {			
			new	Float:x = floatsin(lat + 90.0, degrees) * floatcos(lon + 90.0, degrees);
				Float:y = floatsin(lat + 90.0, degrees) * floatsin(lon + 90.0, degrees);
				Float:z = floatcos(-lat + 90.0, degrees);
			
			printf("[%3.3f, %3.3f] %4.4f, %4.4f, %4.4f | %4.4f, %4.4f, %4.4f", lat, lon, x, y, z, 180.0 * x, 180.0 * y, -lat);
		}
	}
	return 1;
}
```

# Generic Sphere Creation
### _Literally just creates the sphere._

```pawn
/*  R = Radius.
    pos? = Center position on map.
    hsep = Angle between latitude lines.
    lsep = Angle between longitude lines.
    deg = Degrees of the sphere (ex. 180 = hemisphere, 360 = sphere).	*/

//
new Float:x, Float:y, Float:z;
for(new Float:lon = -90.0; lon <= 90.0; lon += hsep)
for(new Float:lat = 0.0, Float:angle = float(clamp(deg, 0, 360)); lat <= angle; lat += vsep)
{
	x = floatsin(lat + 90.0, degrees) * floatcos(lon + 90.0, degrees);
	y = floatsin(lat + 90.0, degrees) * floatsin(lon + 90.0, degrees);
	z = floatcos(-lat + 90.0, degrees);
	CreateObject(modelid, posx + (x * R), posy + (y * R), posz + (z * R), rx, ry, rz);
}
```
