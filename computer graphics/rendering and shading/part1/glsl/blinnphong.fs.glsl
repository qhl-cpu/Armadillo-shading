// HINT: Don't forget to define the uniforms here after you pass them in in A3.js
uniform vec3 ambientColor;
uniform vec3 diffuseColor;
uniform vec3 specularColor;
uniform vec3 lightColor;

uniform float kSpecular;
uniform float kAmbient;
uniform float kDiffuse;
uniform float shininess;
// The value of our shared variable is given as the interpolation between normals computed in the vertex shader
// below we can see the shared variable we passed from the vertex shader using the 'in' classifier
in vec3 interpolatedNormal;
in vec3 lightDirection;
in vec3 viewPosition;

void main() {
    // HINT: Compute the ambient component as you did in the Phong shader.
    // HINT: Compute the diffuse component as you did in the Phong shader.
    // HINT: Compute the specular component. Recall from the specs that the
    // difference between the specular terms in the Phong and Blinn-Phong models

    float diffuse = dot(interpolatedNormal, lightDirection);

    vec3 viewPosition = normalize(vec3(0.0,0.0,0.0) - viewPosition);

    vec3 halfWayVec =  normalize(lightDirection + viewPosition);

    float sum = clamp(dot(halfWayVec,interpolatedNormal),0.0,1.0);
    float specular =  kSpecular * pow(max(0.0, sum), shininess);

    diffuse = diffuse * kDiffuse;

    vec3 intensity = kAmbient * ambientColor + diffuse * diffuseColor + specular * specularColor ;


    // HINT: Set final rendered colour to be a combination of the three components
    gl_FragColor = vec4(intensity, 1.0);

}
