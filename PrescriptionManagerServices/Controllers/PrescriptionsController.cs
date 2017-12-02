
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
    [Route("api/Prescriptions")]
    public class PrescriptionsController : Controller
    {
        private readonly ContosoMedicalDBContext _context;

        public PrescriptionsController(ContosoMedicalDBContext context)
        {
            _context = context;
        }

        // GET: api/Prescriptions
        [HttpGet]
        public IEnumerable<Prescriptions> GetPrescriptions(DateTime? fromDate, DateTime? toDate)
        {
            if (fromDate.HasValue && toDate.HasValue)
            {
                return _context.Prescriptions.Where(p => p.IssueDate >= fromDate.Value && p.IssueDate <= toDate.Value).Include(p => p.Patient);
            }

            return _context.Prescriptions;
        }

        // GET: api/Prescriptions
        [HttpGet("~/api/Patients/{patientId}/Prescriptions")]
        public IEnumerable<Prescriptions> GetPatientPrescriptions(int patientId)
        {
            return _context.Prescriptions.Where(p => p.PatientId == patientId).ToList();
        }

        // GET: api/Prescriptions/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetPrescriptions([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var prescriptions = await _context.Prescriptions.SingleOrDefaultAsync(m => m.PrescriptionId == id);

            if (prescriptions == null)
            {
                return NotFound();
            }

            return Ok(prescriptions);
        }

        // PUT: api/Prescriptions/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPrescriptions([FromRoute] int id, [FromBody] Prescriptions prescriptions)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != prescriptions.PrescriptionId)
            {
                return BadRequest();
            }

            _context.Entry(prescriptions).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PrescriptionsExists(id))
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

        // POST: api/Prescriptions
        [HttpPost]
        public async Task<IActionResult> PostPrescriptions([FromBody] Prescriptions prescriptions)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Prescriptions.Add(prescriptions);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetPrescriptions", new { id = prescriptions.PrescriptionId }, prescriptions);
        }

        // DELETE: api/Prescriptions/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePrescriptions([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var prescriptions = await _context.Prescriptions.SingleOrDefaultAsync(m => m.PrescriptionId == id);
            if (prescriptions == null)
            {
                return NotFound();
            }

            _context.Prescriptions.Remove(prescriptions);
            await _context.SaveChangesAsync();

            return Ok(prescriptions);
        }

        private bool PrescriptionsExists(int id)
        {
            return _context.Prescriptions.Any(e => e.PrescriptionId == id);
        }
    }
}