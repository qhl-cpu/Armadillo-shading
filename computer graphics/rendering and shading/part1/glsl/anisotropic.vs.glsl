// The uniform variable is set up in the javascript code and the same for all vertices
uniform vec3 spherePosition;
uniform vec3 tangentDirection;

// The shared variable is initialized in the vertex shader and attached to the current vertex being processed,
// such that each vertex is given a shared variable and when passed to the fragment shader,
// these values are interpolated between vertices and across fragments,
// below we can see the shared variable is initialized in the vertex shader using the 'out' classifier
out vec3 interpolatedNormal;
out vec3 lightDirection;
out vec3 viewPosition;
out vec3 transformTan;

void main() {
    // HINT: Compute the vertex position in VCS
    // HINT: Compute the light direction in VCS
    // HINT: Interpolate the normal
    vec4 viewPositionTemp =viewMatrix *  modelMatrix * vec4(position, 1.0);
    viewPosition = normalize(vec3(viewPositionTemp));
     transformTan = normalize(vec3(viewMatrix * vec4(tangentDirection,0.0)));

	vec4 sum =  viewMatrix * vec4(spherePosition,1.0) - viewPositionTemp;
	lightDirection = normalize(vec3(sum));

    //vec4 norm =viewMatrix * modelMatrix * vec4(normal,0.0);
    vec3 norm = normalMatrix*normal;
    interpolatedNormal = normalize(vec3(norm));

    // Multiply each vertex by the model matrix to get the world position of each vertex, 
    // then the view matrix to get the position in the camera coordinate system, 
    // and finally the projection matrix to get final vertex position
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
