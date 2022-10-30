#version 300 es

out vec2 texCoords;
out vec3 vNormal;
out vec4 vPosition;
out vec4 worldCoord;

uniform vec3 cameraPositionUniform;

void main() {
    // Q1c) HINT : The cube that the texture is mapped to is centered at the origin, using this information
    // calculate the correct direction vector in the world coordinate system
    // which is used to sample a color from the cubemap

    texCoords = uv;

    //vNormal = normal;
    vec4 norm =viewMatrix * modelMatrix * vec4(normal,0.0);
    vNormal = (vec3(norm));

    vPosition = viewMatrix* modelMatrix * vec4(position, 0.0);
    worldCoord = modelMatrix * vec4(position, 1.0) + vec4(cameraPositionUniform,1.0);
    // Q1c) HINT : Offset your pixel vertex position by the cameraPostion (given to you in world space)
    // so that the cube is always in front of the camera even with zoom
    gl_Position = projectionMatrix * viewMatrix * (modelMatrix * vec4(position, 1.0) + vec4(cameraPositionUniform,1.0));
}