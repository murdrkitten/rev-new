//::///////////////////////////////////////////////
//:: [Name]: inc_position.nss
//:: [Authors]: murdrkitten
//:: [Functionality]: Include functions for positioning
//::///////////////////////////////////////////////

// Returns the very center of oArea.
vector POSITION_GetCenterOfArea(object oArea);

// Returns if a position in an area is walkable or not.
int POSITION_GetIsWalkable (object oArea, vector vPos);

vector POSITION_GetCenterOfArea(object oArea)
{
    int nHeight = GetAreaSize(AREA_HEIGHT, oArea) * 10;
    int nWidth =  GetAreaSize(AREA_WIDTH, oArea) * 10;

    float xCoord = IntToFloat( nWidth / 2 );
    float yCoord = IntToFloat( nHeight / 2 );
    float zCoord = GetGroundHeight( Location( oArea, Vector(xCoord, yCoord, 0.00), 0.00 ) );

    return Vector(xCoord, yCoord, zCoord);
}

int POSITION_GetIsWalkable (object oArea, vector vPos)
{
    location l = Location(oArea, vPos, 0.0);
    int material = GetSurfaceMaterial(l);
    return StringToInt(Get2DAString("surfacemat", "Walk", material));
}
