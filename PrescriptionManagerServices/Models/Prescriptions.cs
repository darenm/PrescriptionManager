using System;
using System.Collections.Generic;

namespace PrescriptionManagerServices.Models
{
    public partial class Prescriptions
    {
        public int PrescriptionId { get; set; }
        public int PatientId { get; set; }
        public string Description { get; set; }
        public DateTime IssueDate { get; set; }
        public int RepeatCount { get; set; }
        public Patients Patient { get; set; }
    }
}
