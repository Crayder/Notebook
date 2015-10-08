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

# Test version of the above

```pawn
new Float:x, Float:y, Float:z, Float:angle = float(clamp(deg, 0, 360)), Float:detrx, Float:detry, Float:detrz;
for(new Float:lat = -90.0; lat <= 90.0; lat += hsep)
for(new Float:lon = 0.0; lon <= angle; lon += vsep) if(lat % 90.0 || lon == 0.0)
{
	//x = floatsin(lat + 90.0, degrees) * floatcos(lon + 90.0, degrees);
	//y = floatsin(lat + 90.0, degrees) * floatsin(lon + 90.0, degrees);
	//z = floatcos(-lat + 90.0, degrees);
	x = -floatcos(lat, degrees) * floatsin(lon, degrees);
	y = floatcos(lat, degrees) * floatcos(lon, degrees);
	z = floatsin(lat, degrees);
	
	printf("[%4.4f, %4.4f] %4.4f, %4.4f, %4.4f\n",
			lat,    lon,   -x,     -y,     -z
	);
	
	AttachPoint(x * radius, y * radius, z * radius, x * 180.0, y * 180.0, -lat,
		posx, posy, posz, rx, ry, rz,
		x, y, z, detrx, detry, detrz
	);
	
	AddOBMObject(playerid, modelid, posx + x, posy + y, posz + z, detrx, detry, detrz);
}
```
