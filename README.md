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

# Test versions of the above
#### _1_
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
#### _2_
```pawn
public OnRconCommand(cmd[])
{
	new cmdname[24], Float:Radius, Float:lat, Float:lon;
	if(!sscanf(cmd, "s[24]fff", cmdname, Radius, lat, lon)) {
		if(!strcmp(cmdname, "set")) {
			new	Float:x = floatsin(lat + 90.0, degrees) * floatcos(lon + 90.0, degrees),
				Float:y = floatsin(lat + 90.0, degrees) * floatsin(lon + 90.0, degrees),
				Float:z = floatcos(-lat + 90.0, degrees);
			
			FloatRemainder((lon = -(acos((-z) / Radius) - 90.0), lon), 360.0); 
			FloatRemainder((lat = (atan2(-y, -x) - 90.0), lat), 360.0);

			printf("%4.4f, %4.4f, %4.4f | %4.4f, %4.4f\n",
				Radius * x, Radius * y, Radius * z,
				lat, lon);
		}
	}
	return 1;
}

stock FloatRemainder(&Float:remainder, Float:value)
{
	while(remainder >= value)
		remainder = remainder - value;
	while(remainder < 0.0)
		remainder = remainder + value;
}
```
#### _3_
```pawn
new Float:x, Float:y, Float:z, Float:angle = float(clamp(deg, 0, 360)), Float:detrx, Float:detry, Float:detrz;
for(new Float:lat = -90.0; lat <= 90.0; lat += hsep)
for(new Float:lon = 0.0; lon <= angle; lon += vsep)//if(lat % 90.0 || lon == 0.0)
{
	x = floatsin(lat + 90.0, degrees) * floatcos(lon + 90.0, degrees);
	y = floatsin(lat + 90.0, degrees) * floatsin(lon + 90.0, degrees);
	z = floatcos(-lat + 90.0, degrees);
	
	EDIT_FloatRemainder((detrx = -(acos((-z) / 1.0) - 90.0), detrx), 360.0); 
	EDIT_FloatRemainder((detrz = (atan2(-y, -x) - 90.0), detrz), 360.0);
	
	AttachPoint(x * radius, y * radius, z * radius, orx + detrx, ory + detry, orz + detrz - 180.0,
		posx, posy, posz, rx, ry, rz,
		x, y, z, detrx, detry, detrz
	);
	
	AddOBMObject(playerid, modelid, posx + x, posy + y, posz + z, detrx, detry, detrz);
}
```
Test 3 is the closest to what I want. It is mostly failing, but some of it is right. Here are the results, with the red ones being correct.

[Imgur](http://i.imgur.com/KLkvXIP.png?1)
