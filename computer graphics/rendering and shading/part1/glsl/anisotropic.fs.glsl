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
in vec3 transformTan;

void main() {
    // HINT: You may find it helpful to pre-compute some values here (e.g. normalized vectors)
    // HINT: Compute the ambient component. Like in Phong, this component is uniform across surface.
    vec3 ambient = kAmbient * ambientColor;
    vec3 viewPosition2 = normalize(vec3(0.0,0.0,0.0) -viewPosition);
    // HINT: Compute the diffuse component, according to the Heidrich-Seidel model.
    // You may find this link helpful:
    // https://en.wikipedia.org/wiki/Specular_highlight#Heidrich%E2%80%93Seidel_anisotropic_distribution
    // HINT: Compute the specular component. This will depend on the view direction.
    // you are allowed to use the optimized formula as well (see above link).
    // HINT: Make sure that the light only affects vertices facing towards the light.
    // HINT: Set final rendered colour to be a combination of the three components

    vec3 lightDirection1=normalize(lightDirection);
    vec3 transformedTan = normalize(transformTan);

    //vec3 threadDir = normalize(vec3(viewMatrix * vec4(tangentDirection,0.0)));
    //vec3 threadDirNorm = normalize(threadDir);

    //vecT is Thread direction based on real surface normal.
    vec3 vecT = normalize(transformedTan+dot(-1.0 *transformedTan,interpolatedNormal)*interpolatedNormal);
    //vec3 vecT = transformedTan - (dot(transformedTan,interpolatedNormal))*interpolatedNormal;
    vec3 vecP = normalize(lightDirection1+dot(-1.0*lightDirection1,vecT)*vecT);
    //vecP Projection of vector L onto plane with normal T ( in original paper this appears as N )

    //float diffuse0 = sqrt(1.0- pow(dot(lightDirection1,vecT),2.0));
    //vecR Reflected incoming light ray against T. Incoming light ray is equal to negative L.
    vec3 vecR = normalize(-1.0*lightDirection1 + 2.0*dot(lightDirection1,vecP)*vecP);
    float diffuse0 = max(0.0,dot(lightDirection,vecP));
    float specular0 = clamp(pow(dot(viewPosition2,vecR),shininess),0.0,1.0);
    //vec3 specular = kSpecular * specular0 * specularColor;
    // float sum = clamp(dot(halfWayVec,interpolatedNormal),0.0,1.0);
    // float specular =  kSpecular * pow(max(0.0, sum), shininess);

    // diffuse = diffuse * kDiffuse;
    //vec3 intensity = ambient + diffuse ;

    vec3 intensity;
    if (dot(interpolatedNormal,viewPosition2)<= 0.0 || dot(vecP,viewPosition2)<= 0.0 || dot(vecR,viewPosition2)<= 0.0) {
         specular0 = 0.0;
        //diffuse0 = 0.0;
    }

    gl_FragColor = vec4(0.0,0.0,0.0, 1.0);
    vec3 diffuse = kDiffuse * diffuse0 * diffuseColor; 
        vec3 specular = kSpecular * specular0 * specularColor;
        intensity = ambient + (diffuse +specular) * max(0.0,dot(lightDirection,interpolatedNormal));
    gl_FragColor += vec4(intensity, 1.0);
    // vec3 intensity;
    // if (clamp(dot(interpolatedNormal,viewPosition2),0.0,1.0)> 0.0 && clamp(dot(vecP,viewPosition2),0.0,1.0)> 0.0 && clamp(dot(vecR,viewPosition2),0.0,1.0)> 0.0) {
    //     intensity = ambient + diffuse + specular ;
    // }else {
    //     //intensity = vec3(0.0,0.0,0.0);
    //     intensity = ambient;
    //     //gl_FragColor = vec4(0.0,0.0,0.0, 1.0);
    // }
// vec3 specular = kSpecular * specular0 * specularColor;
//         vec3 intensity;
//     if (dot(interpolatedNormal,viewPosition2)> 0.0 && dot(vecP,viewPosition2)> 0.0 && dot(vecR,viewPosition2)> 0.0) {
//         intensity = ambient + diffuse +specular;
//     }else {
//         //intensity = vec3(0.0,0.0,0.0);
//         intensity = ambient + diffuse;
//         //gl_FragColor = vec4(0.0,0.0,0.0, 1.0);
//     }
    
    //gl_FragColor = vec4(0.42, 0.0, 0.69, 1.0);




}
