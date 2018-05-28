using UnityEngine;

public class ParticleCounter : MonoBehaviour {


    [SerializeField]
    private ParticleSystem particle;

    [SerializeField]
    private GUIStyle particleStyle;
	
    private void OnGUI()
    {
        GUILayout.Label("Partcle Count: " + particle.particleCount, particleStyle);
    }
}
