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
