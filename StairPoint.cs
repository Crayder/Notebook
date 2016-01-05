	static void StairPoint(bool invert, float rotation, float offx, float offy, float offz, ref float RetX, ref float RetY, ref float RetZ)
	{
		//Wrap rotations to be between 0 and 360.
		while (rotation < 0.0f)
			rotation += 360.0f;
		while (rotation >= 360.0f)
			rotation -= 360.0f;

		//Invert Z axis, if necessary.
		if (invert)
		{
			offz *= -1.0f;
			offz += 1.0f;
		}
		
		//Simulate rX and rY.
		float prx = 0.00000002f, pry = 0.00000002f;

		//Pre-calculate trigonometry for efficiency.
		float sin_x = (float)Math.Sin((double)prx * (180 / Math.PI));
		float sin_y = (float)Math.Sin((double)pry * (180 / Math.PI));
		float sin_z = (float)Math.Sin((double)rotation * (180 / Math.PI));
		float cos_x = (float)Math.Cos((double)prx * (180 / Math.PI));
		float cos_y = (float)Math.Cos((double)pry * (180 / Math.PI));
		float cos_z = (float)Math.Cos((double)rotation * (180 / Math.PI));

		//Get new position, to the nearest half.
		RetX = (float)Math.Round((0.5f /*px*/ + offx * cos_y * cos_z - offx * sin_x * sin_y * sin_z - offy * cos_x * sin_z + offz * sin_y * cos_z + offz * sin_x * cos_y * sin_z) * 2.0f) / 2.0f;
		RetY = (float)Math.Round((0.5f /*py*/ + offx * cos_y * sin_z + offx * sin_x * sin_y * cos_z + offy * cos_x * cos_z + offz * sin_y * sin_z - offz * sin_x * cos_y * cos_z) * 2.0f) / 2.0f;
		RetZ = (float)Math.Round((0.5f /*pz*/ - offx * cos_x * sin_y + offy * sin_x + offz * cos_x * cos_y) * 2.0f) / 2.0f;
	}
