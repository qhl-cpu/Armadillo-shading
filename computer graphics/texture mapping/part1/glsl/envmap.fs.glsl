#version 300 es

in vec3 vcsNormal;
in vec3 vcsPosition;

out vec4 out_FragColor;
uniform samplerCube skyboxCubemap;
uniform vec3 cameraPositionUniform;

void main() {
    // Q1d) HINT : Calculate the vector that can be used to sample from the cubemap
    vec3 vvnormal = normalize(vcsNormal);
    vec3 reflected =  2.0*dot(normalize(vec3(-vcsPosition)),vcsNormal)*vcsNormal - normalize(vec3(-vcsPosition));
    //vec3 reflected = reflect(normalize(vec3(-vPosition)),vvnormal);
    vec3 texColor0 = vec3(texture(skyboxCubemap,vec3(reflected)));
    // Q1c) HINT : REPLACE THIS LINE
    //out_FragColor = texture(skyboxCubemap,texCoords);
    out_FragColor = vec4(texColor0, 1.0);;
    //out_FragColor = vec4(0.2, 0.0, 0.1, 1.0);
}