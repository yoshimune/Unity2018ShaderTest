using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraRotation : MonoBehaviour {

    public Vector3 speed;
    
    private void FixedUpdate()
    {
        transform.Rotate(speed);
    }
}
