using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CreateManyMesh : MonoBehaviour {

    [SerializeField]
    int count;

    [SerializeField]
    float range = 10.0f;

    [SerializeField]
    float speed = 0.1f;

    List<Vector3> posList;
    List<Vector3> rotList;
    //List<float> offsetList;

    [SerializeField]
    Mesh mesh;

    [SerializeField]
    Material material;

    MaterialPropertyBlock prop;

	// Use this for initialization
	void Start () {
        prop = new MaterialPropertyBlock();

        posList = new List<Vector3>();
        rotList = new List<Vector3>();
        //offsetList = new List<float>();
        for (int i = 0; i < count; i++)
        {
            // position 計算

            var position = new Vector3(Random.Range(-0.5f, 0.5f) * range, Random.Range(-0.5f, 0.5f) * range, Random.Range(-0.5f, 0.5f) * range);
            var rotation = new Vector3(Random.Range(20f, 60f), Random.Range(0, 359f) * range, 0);
            posList.Add(position);
            rotList.Add(rotation);
            //offsetList.Add(Random.Range(0, 1.0f));
        }
    }

    // Update is called once per frame
    void Update () {
        for (int i = 0; i < count; i++)
        {
            Vector3 pos = posList[i] + (Vector3.up * Time.deltaTime * speed);
            if (pos.y > range*0.5f) { pos = new Vector3(pos.x, range * -0.5f, pos.z); }
            posList[i] = pos;
            //prop.SetFloat("_Speed", (i%5)+5);
            prop.SetFloat("_OffsetRotate", (i%10));
            Graphics.DrawMesh(mesh, posList[i], Quaternion.Euler(rotList[i].x, rotList[i].y, rotList[i].z), material, 0, null, 0, prop);
        }
    }
}
