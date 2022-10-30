// HINT: Don't forget to define the uniforms here after you pass them in in A3.js
uniform vec3 toonColor;
uniform vec3 toonColor2;
uniform vec3 outlineColor;

// The value of our shared variable is given as the interpolation between normals computed in the vertex shader
// below we can see the shared variable we passed from the vertex shader using the 'in' classifier
in vec3 interpolatedNormal;
in vec3 lightDirection;
in vec3 viewPosition;
in float fresnel;

void main() {
    // HINT: Compute the light intensity the current fragment by determining
    // the cosine angle between the surface normal and the light vector
    float lightIntensity = 2.0 * dot (interpolatedNormal,lightDirection);
    lightIntensity = ceil(lightIntensity)/2.0;

    
    // vec3 toonColor11 = vec3(toonColor);//yellow
    // vec3 toonColor22 = vec3(toonColor2);//red
    //vec3 combinedColor = (toonColor+toonColor2);

    vec3 combinedColor = lightIntensity * toonColor + (1.0-lightIntensity)* toonColor2;
	
    if (fresnel <= 0.45 && fresnel >= -0.5) {
        gl_FragColor = vec4(outlineColor,1.0);
        combinedColor = vec3(0.0,0.0,0.0);
    }

    gl_FragColor += vec4(combinedColor, 1.0); // REPLACE ME
	
}
