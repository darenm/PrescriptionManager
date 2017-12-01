using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PrescriptionManagerServices.Models;

namespace PrescriptionManagerServices.Controllers
{
    [Produces("application/json")]
    [Route("api/Patients")]
    public class PatientsController : Controller
    {
        private readonly ContosoMedicalDBContext _context;

        public PatientsController(ContosoMedicalDBContext context)
        {
            _context = context;
        }

        // GET: api/Patients
        [HttpGet]
        public IEnumerable<Patients> GetPatients()
        {
            return _context.Patients;
        }

        // GET: api/Patients/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetPatients([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var patients = await _context.Patients.SingleOrDefaultAsync(m => m.PatientId == id);

            if (patients == null)
            {
                return NotFound();
            }

            return Ok(patients);
        }

        // PUT: api/Patients/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPatients([FromRoute] int id, [FromBody] Patients patients)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != patients.PatientId)
            {
                return BadRequest();
            }

            _context.Entry(patients).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PatientsExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Patients
        [HttpPost]
        public async Task<IActionResult> PostPatients([FromBody] Patients patients)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Patients.Add(patients);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPatients", new { id = patients.PatientId }, patients);
        }

        // DELETE: api/Patients/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePatients([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var patients = await _context.Patients.SingleOrDefaultAsync(m => m.PatientId == id);
            if (patients == null)
            {
                return NotFound();
            }

            _context.Patients.Remove(patients);
            await _context.SaveChangesAsync();

            return Ok(patients);
        }

        private bool PatientsExists(int id)
        {
            return _context.Patients.Any(e => e.PatientId == id);
        }
    }
}