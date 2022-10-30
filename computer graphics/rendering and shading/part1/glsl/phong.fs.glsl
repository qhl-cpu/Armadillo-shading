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
    // HINT: Compute the ambient component. This component is uniform across surface.
    // HINT: Compute the diffuse component. This component varies with direction.
    // You may find it useful to review Chapter 14.2 in the textbook.
    
    //vec3 toLight = normalize(uLight - vec3(vPosition));
    //vec3 normal = normalize(vNormal);

    float diffuse =dot(interpolatedNormal, lightDirection);
    //vec3 intensity = ambientColor * diffuse ;
    
    // HINT: Compute the specular component. This component varies with direction,
    // and is what gives the model its "shine." You may find it useful to review
    // Chapter 14.3 in the textbook.

    vec3 bounceVec =  -1.0* lightDirection + 2.0*(diffuse) * interpolatedNormal;
    bounceVec = normalize(bounceVec);
    vec3 viewPosition2 = normalize(vec3(0.0,0.0,0.0) -viewPosition);

    float sum = clamp(dot(bounceVec,viewPosition2),0.0,1.0);
    float specular =  kSpecular * pow(max(0.0, sum), shininess);

    diffuse = diffuse * kDiffuse;
    //vec3 intensity = ambientColor * diffuse  + specular * specularColor;

    vec3 intensity = kAmbient * ambientColor + diffuse * diffuseColor + specular * specularColor ;


    // HINT: Set final rendered colour to be a combination of the three components
    //gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
    gl_FragColor = vec4(intensity, 1.0);
}
