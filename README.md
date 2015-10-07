# Sphere and cosine directionals (Incomplete).
## Returns a point on a sphere give latitude and longitude angles. Also returns the cosine directionals needed to 'point' to the center.

```pawn
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
```

# Generic Sphere Creation
## Literally just creates the sphere.

```pawn
/*  R = Radius.
    pos? = Center position on map.  */

// The angles are very generic and still need to be fixed, but the sphere is created exactly as it should be. The angles need to be more 'central'.

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
