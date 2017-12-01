using System;
using System.Collections.Generic;

namespace PrescriptionManagerServices.Models
{
    public partial class Doctors
    {
        public Doctors()
        {
            Appointments = new HashSet<Appointments>();
        }

        public int DoctorId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Specialty { get; set; }

        public ICollection<Appointments> Appointments { get; set; }
    }
}
