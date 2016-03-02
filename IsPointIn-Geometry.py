import math

def Magnitude(point1, point2):
    vec = [
        point2[0] - point1[0],
        point2[1] - point1[1],
        point2[2] - point1[2]
    ]
    return math.sqrt(vec[0] ** 2 + vec[1] ** 2 + vec[2] ** 2)

def DistanceFromPointToLine(Point, LineStart, LineEnd):
    LineMag = Magnitude(LineEnd, LineStart);
    LineMag *= LineMag;
    
    if (LineMag < 0.001):
    	return -1.0
    
    U = (((Point[0] - LineStart[0]) * (LineEnd[0] - LineStart[0])) + ((Point[1] - LineStart[1]) * (LineEnd[1] - LineStart[1])) + ((Point[2] - LineStart[2]) * (LineEnd[2] - LineStart[2]))) / LineMag
    
    if (U < 0.0 or U > 1.0):
        return -1.0
    
    Intersection = [0, 0, 0]
    
    Intersection[0] = LineStart[0] + U * (LineEnd[0] - LineStart[0])
    Intersection[1] = LineStart[1] + U * (LineEnd[1] - LineStart[1])
    Intersection[2] = LineStart[2] + U * (LineEnd[2] - LineStart[2])
    
    return (Magnitude(Intersection, Point), Intersection)

def IsPointInCone(test_point, base_center, base_radius, top_center, top_radius):
	cylinder_length = Magnitude(base_center, top_center)
	(distance, intersection) = DistanceFromPointToLine(test_point, base_center, top_center)
	radius = (Magnitude(intersection, base_center) / cylinder_length * top_radius) + (Magnitude(intersection, top_center) / cylinder_length * base_radius)
	
	return (distance != -1.0 and distance <= radius)

def IsPointInCylinder(test_point, base_center, top_center, radius):
	cylinder_length = Magnitude(base_center, top_center)
	(distance, intersection) = DistanceFromPointToLine(test_point, base_center, top_center)
	radius = (Magnitude(intersection, base_center) / cylinder_length * top_radius) + (Magnitude(intersection, top_center) / cylinder_length * base_radius)
	
	return (distance != -1.0 and distance <= radius)

def IsPointInSphere(test_point, center, radius):
	return (Magnitude(center, test_point) <= radius)
