// Laser Tripwire and Promoxity Mine Concept

#include a_samp
#include YSI\y_timers

// Utility Functions
#define Magnitude(%0,%1) \
    VectorSize(%1[0]-%0[0],%1[1]-%0[1],%1[2]-%0[2])

stock Float:DistanceFromPointToLine(Float:Point[3], Float:LineStart[3], Float:LineEnd[3], Float:Intersection[3]) {
    new Float:U = (((Point[0] - LineStart[0]) * (LineEnd[0] - LineStart[0])) +
		 ((Point[1] - LineStart[1]) * (LineEnd[1] - LineStart[1])) +
		 ((Point[2] - LineStart[2]) * (LineEnd[2] - LineStart[2]))) /
         floatpower(Magnitude(LineEnd, LineStart), 2.0);
    
    if(U < 0.0 || U > 1.0)
        return -1.0;
    
    Intersection[0] = LineStart[0] + U * (LineEnd[0] - LineStart[0]);
    Intersection[1] = LineStart[1] + U * (LineEnd[1] - LineStart[1]);
    Intersection[2] = LineStart[2] + U * (LineEnd[2] - LineStart[2]);
    
    return Magnitude(Intersection, Point);
}

stock bool:IsPointInCone(Float:test_point[3], Float:base_center[3], Float:base_radius, Float:top_center[3], Float:top_radius) {
	new Float:cylinder_length = Magnitude(base_center, top_center),
		Float:intersection[3],
		Float:distance = DistanceFromPointToLine(test_point, base_center, top_center, intersection),
		Float:radius = (Magnitude(intersection, base_center) / cylinder_length * top_radius) + (Magnitude(intersection, top_center) / cylinder_length * base_radius);
	
	return (distance != -1.0 && distance <= radius);
}

stock bool:IsPointInCylinder(Float:test_point[3], Float:base_center[3], Float:top_center[3], Float:radius) {
	new Float:cylinder_length = Magnitude(base_center, top_center),
		Float:intersection[3],
		Float:distance = DistanceFromPointToLine(test_point, base_center, top_center, intersection),
		Float:radius = (Magnitude(intersection, base_center) / cylinder_length * radius) + (Magnitude(intersection, top_center) / cylinder_length * radius);
	
	return (distance != -1.0 && distance <= radius);
}

stock bool:IsPointInSphere(Float:test_point[3], Float:center[3], Float:radius) {
	return (Magnitude(center, test_point) <= r);
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//

new bool:upcheck[MAX_PLAYERS];

task resetUpcheck[100]() {
    new bool:def_upcheck[MAX_PLAYERS] = {true, ...};
    upcheck = def_upcheck;
}

enum ConicInfo {
    cObject,

    Float:cBaseX, Float:cBaseY, Float:cBaseZ,
    Float:cBaseR,
    
    Float:cTopX, Float:cTopY, Float:cTopZ,
    Float:cTopR,
    
    Float:cLen
}
new Iterator:LaserMine<10>, Iterator:ProxiMine<10>, laserMine[10][ConicInfo], proxiMine[10][ConicInfo];

stock AddLaserMine(Float:x, Float:y, Float:z, Float:vx, Float:vy, Float:vz, Float:distance) {
    new i = Iter_Alloc(LaserMine);
    
    if(i == -1 || i == cellmin)
        return -1;
    
    laserMine[i][cBaseX] = x;
    laserMine[i][cBaseY] = y;
    laserMine[i][cBaseZ] = z;
    
    laserMine[i][cTopX] = x + (vx * distance);
    laserMine[i][cTopY] = y + (vy * distance);
    laserMine[i][cTopZ] = z + (vz * distance);
    
    laserMine[i][cBaseR] = laserMine[i][cTopR] = 1.0;
    
    return i;
}

stock AddProxiMine(Float:x, Float:y, Float:z, Float:vx, Float:vy, Float:vz, Float:distance) {
    new i = Iter_Alloc(ProxiMine);
    
    if(i == -1 || i == cellmin)
        return -1;
    
    proxiMine[i][cBaseX] = x;
    proxiMine[i][cBaseY] = y;
    proxiMine[i][cBaseZ] = z;
    
    proxiMine[i][cTopX] = x + (vx * distance);
    proxiMine[i][cTopY] = y + (vy * distance);
    proxiMine[i][cTopZ] = z + (vz * distance);
    
    proxiMine[i][cBaseR] = 1.0;
    proxiMine[i][cTopR] = 1.0 + distance;
    
    return i;
}

stock ExplodeMine(index) {
    if(!Iter_Contains(LaserMine, index))
        return 0;
    
    CreateExplosion(laserMine[index][cBaseX], laserMine[index][cBaseY], laserMine[index][cBaseZ], 0, 10.0);
    
    new conicInfo[ConicInfo];
    laserMine[index] = conicInfo;
    Iter_Remove(LaserMine, index);
    return 1;
}

stock bool:IsPlayerTrippingMine(playerid, index) {
    if(!Iter_Contains(LaserMine, index))
        return -1;
    
    new Float:pos[3], Float:vec1[3], Float:vec2[3];
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    vec1[0] = laserMine[index][cBaseX], vec2[0] = laserMine[ndex][cTopX];
    vec1[1] = laserMine[index][cBaseY], vec2[1] = laserMine[ndex][cTopY];
    vec1[2] = laserMine[index][cBaseZ], vec2[2] = laserMine[ndex][cTopZ];
    
    return IsPointInCone(pos, vec1, laserMine[i][cBaseR], vec2, laserMine[i][cTopR]);
}
stock GetPlayerTrippingMine(playerid) {
    new Float:pos[3], Float:vec1[3], Float:vec2[3];
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    
    new Float:dist, Float:t, m = -1;
    foreach(new i: LaserMine) {
        vec1[0] = laserMine[i][cBaseX], vec2[0] = laserMine[i][cTopX];
        vec1[1] = laserMine[i][cBaseY], vec2[1] = laserMine[i][cTopY];
        vec1[2] = laserMine[i][cBaseZ], vec2[2] = laserMine[i][cTopZ];
        
        if(IsPointInCone(pos, vec1, laserMine[i][cBaseR], vec2, laserMine[i][cTopR])) {
            t = Magnitude(pos, vec1);
            if(t < dist) {
                t = dist;
                m = i;
            }
        }
    }
    // Also check proxi mines
    
    return m;
}

public OnPlayerUpdate(playerid) {
    if(upcheck[playerid]) {
        new m = GetPlayerTrippingMine(playerid);
        
        if(m != -1)
            ExplodeMine(m);
        
        upcheck[playerid] = false;
    }
    return 1;
}
