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

    // Color
    [SerializeField]
    [ColorUsage(true, true, 0f, 8f, 0.125f, 3f)]
    Color fromMainColor;
    [SerializeField]
    [ColorUsage(true, true, 0f, 8f, 0.125f, 3f)]
    Color fromZColor;

    [SerializeField]
    [ColorUsage(true, true, 0f, 8f, 0.125f, 3f)]
    Color toMainColor;
    [SerializeField]
    [ColorUsage(true, true, 0f, 8f, 0.125f, 3f)]
    Color toZColor;

    [SerializeField]
    float mainColorSpeed;
    [SerializeField]
    float zColorSpeed;

    [SerializeField]
    Mesh mesh;

    [SerializeField]
    Material material;

    MaterialPropertyBlock prop;

    //List<Matrix4x4> matrix;

	// Use this for initialization
	void Start () {
        prop = new MaterialPropertyBlock();

        posList = new List<Vector3>();
        rotList = new List<Vector3>();
        //offsetList = new List<float>();
        for (int i = 0; i < count; i++)
        {
            // position 計算

            //var position = new Vector3(Random.Range(-0.5f, 0.5f) * range, Random.Range(-0.5f, 0.5f) * range, Random.Range(-0.5f, 0.5f) * range);

            var theta = Random.Range(0, Mathf.PI * 2.0f);
            var r = Random.Range(0, range);
            var x = Mathf.Cos(theta) * r;
            var z = Mathf.Sin(theta) * r;
            var y = Random.Range(-0.5f, 0.5f) * range;
            var position = new Vector3(x, y, z);

            var rotation = new Vector3(Random.Range(20f, 60f), Random.Range(0, 359f) * range, 0);
            posList.Add(position);
            rotList.Add(rotation);
            //offsetList.Add(Random.Range(0, 1.0f));
        }
        //matrix = new List<Matrix4x4>();
        //matrix.Add(Matrix4x4.identity);
    }

    // Update is called once per frame
    void Update () {

        // Color 計算
        //var time = Time.time;
        //var mainSinTime = Mathf.Sin(time * mainColorSpeed);
        //var zSinTime = Mathf.Sin(time * zColorSpeed);

        //var mainColor = fromMainColor + (mainSinTime * (toMainColor - fromMainColor));
        //var zColor = fromZColor + (zSinTime * (toZColor - fromZColor));

        //var mat = new Material(material);
        //mat.SetColor("_Color", mainColor);
        //mat.SetColor("_ColorZ", zColor);

        for (int i = 0; i < count; i++)
        {
            //Vector3 pos = posList[i] + (Vector3.up * Time.deltaTime * speed);
            //if (pos.y > range*0.5f) { pos = new Vector3(pos.x, range * -0.5f, pos.z); }
            //posList[i] = pos;
            prop.SetFloat("_OffsetRotate", (0));
            Graphics.DrawMesh(mesh, Vector3.zero, Quaternion.identity, material, 0, null, 0, prop);
            //Graphics.DrawMesh(mesh, posList[i], Quaternion.Euler(rotList[i].x, rotList[i].y, rotList[i].z), mat, 0, null, 0, prop);
        }

    }
}
