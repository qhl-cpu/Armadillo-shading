#version 300 es

out vec4 out_FragColor;
in vec2 texCoords;
in vec3 vNormal;
in vec4 vPosition;
in vec4 worldCoord;
// Q1c) HINT : The cubemap texture is of type samplerCube
uniform samplerCube skyboxCubemap;
uniform vec3 cameraPositionUniform;

// vec3 reflect(vec3 w, vec3 n){
//     return n*(dot(w,n)*2.0)-w;
// }

void main() {
    // Q1c) HINT : Sample the texture from the samplerCube object, rememeber that cubeMaps are sampled
    // using a direction vector that you calculated in the vertex shader
    
    vec3 vvnormal = normalize(vNormal);
    vec3 reflected =  2.0*dot(normalize(vec3(-vPosition)),vvnormal)*vvnormal - normalize(vec3(-vPosition));
    //vec3 reflected = reflect(normalize(vec3(-vPosition)),vvnormal);
    vec3 texColor0 = vec3(texture(skyboxCubemap,vec3(worldCoord)));
    // Q1c) HINT : REPLACE THIS LINE
    //out_FragColor = texture(skyboxCubemap,texCoords);
    out_FragColor = vec4(texColor0, 1.0);;
}