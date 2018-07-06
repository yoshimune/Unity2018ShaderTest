using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ParticleController : MonoBehaviour {


    [SerializeField]
    ParticleSystem particle;

    public void UpdateParticle(bool plus)
    {
        int count = plus ? 1000 : -1000;
        var em = particle.emission;
        UpdateParticle( (int)em.rateOverTime.constant + count);
    }

    public void UpdateParticle(int count)
    {
        Debug.Log("count:" + count);
        var em = particle.emission;
        em.rateOverTime = count;
        em.enabled = true;

        particle.Clear();
        particle.Play();
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.A)) {
            UpdateParticle(10000);
        }
        else if(Input.GetKeyDown(KeyCode.S))
        {
            UpdateParticle(11000);
        }
        else if (Input.GetKeyDown(KeyCode.D))
        {
            UpdateParticle(12000);
        }
        else if (Input.GetKeyDown(KeyCode.F))
        {
            UpdateParticle(13000);
        }
        else if (Input.GetKeyDown(KeyCode.G))
        {
            UpdateParticle(14000);
        }
        else if (Input.GetKeyDown(KeyCode.H))
        {
            UpdateParticle(15000);
        }
        else if (Input.GetKeyDown(KeyCode.J))
        {
            UpdateParticle(16000);
        }
        else if (Input.GetKeyDown(KeyCode.K))
        {
            UpdateParticle(17000);
        }
        else if (Input.GetKeyDown(KeyCode.L))
        {
            UpdateParticle(18000);
        }
        else if (Input.GetKeyDown(KeyCode.Z))
        {
            UpdateParticle(19000);
        }
        else if (Input.GetKeyDown(KeyCode.X))
        {
            UpdateParticle(20000);
        }
        else if (Input.GetKeyDown(KeyCode.C))
        {
            UpdateParticle(21000);
        }
        else if (Input.GetKeyDown(KeyCode.V))
        {
            UpdateParticle(22000);
        }
        else if (Input.GetKeyDown(KeyCode.B))
        {
            UpdateParticle(23000);
        }
        else if (Input.GetKeyDown(KeyCode.N))
        {
            UpdateParticle(24000);
        }
        else if (Input.GetKeyDown(KeyCode.M))
        {
            UpdateParticle(25000);
        }
        else if (Input.GetKeyDown(KeyCode.Q))
        {
            UpdateParticle(26000);
        }
        else if (Input.GetKeyDown(KeyCode.W))
        {
            UpdateParticle(27000);
        }
        else if (Input.GetKeyDown(KeyCode.E))
        {
            UpdateParticle(28000);
        }
        else if (Input.GetKeyDown(KeyCode.R))
        {
            UpdateParticle(29000);
        }
        else if (Input.GetKeyDown(KeyCode.T))
        {
            UpdateParticle(30000);
        }
    }
}
