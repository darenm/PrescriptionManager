using System;
using System.Collections.Generic;

namespace PrescriptionManagerServices.Models
{
    public partial class Appointments
    {
        public int AppointmentId { get; set; }
        public int DoctorId { get; set; }
        public int PatientId { get; set; }
        public DateTime AppointmentDateTime { get; set; }
        public string Notes { get; set; }

        public Doctors Doctor { get; set; }
        public Patients Patient { get; set; }
    }
}
