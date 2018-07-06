using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ButterflyCounter : MonoBehaviour {

    [SerializeField]
    CreateManyMesh manyMesh;

    [SerializeField]
    private GUIStyle style;

    private void OnGUI()
    {
        GUILayout.Label("Count: " + manyMesh.count, style);
    }
}
