#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;
in vec2 texCoord;

uniform sampler2D colorMap;
uniform vec3 lightColor;
uniform float kDiffuse;
uniform vec3 lightDirection;
uniform float kAmbient;
uniform float kSpecular;
uniform vec3 ambientColor;
uniform float shininess;
// Q1b) HINT : Remember to list uniforms here

void main() {
    // Some pre-calculations for Blinn-Phong lighting
    vec3 N = normalize(vcsNormal);
    vec3 L = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0)));


    vec2 texCoordNew = texCoord;
    texCoordNew.y = 1.0-texCoordNew.y;
    // Q1b) HINT : Compute the ambient, diffuse, and specular components
    // for Blinn-Phong. We've already done diffuse for you.
    vec3 sampledColor = vec3(texture(colorMap,texCoordNew));
	vec3 diffuse = kDiffuse * lightColor * sampledColor;
	vec3 light_DFF = diffuse * max(0.0, dot(N, L));

    
    // Q1b) HINT : Multiply the diffuse color with the color sampled from the texture
    //float diffuse = dot(interpolatedNormal, lightDirection);
    vec3 viewPosition = normalize(vec3(0.0,0.0,0.0) - vcsPosition);
    vec3 halfWayVec =  normalize(L + viewPosition);
    float sum = clamp(dot(halfWayVec,N),0.0,1.0);
    float specular =  kSpecular * pow(max(0.0, sum), shininess);
    //diffuse = diffuse * kDiffuse;

    vec3 intensity = kAmbient * ambientColor +light_DFF + specular * lightColor ;
    // vec4 ambientC = vec4(kAmbient * ambientColor,1.0);
    // vec4 diffuseC = vec4(light_DFF,1.0);
    // vec4 specularC = vec4(specular * lightColor,1.0);
    // Q1b) HINT : REPLACE THIS LINE
    //out_FragColor = ambientC + diffuseC + specularC;
    out_FragColor = vec4(intensity, 1.0);
    //out_FragColor = texture(colorMap,texCoordNew);
}