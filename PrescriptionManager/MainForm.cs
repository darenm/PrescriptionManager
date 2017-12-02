﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using System.Data.Linq;
using PrescriptionManagerServices.Models;
using PrescriptionManagerServicesClient;

namespace PrescriptionManager
{
    public partial class MainForm : Form
    {
        #region Variables, initialization, and selection events

        // Typed DataContext object.
        private ContosoMedicalDataClassesDataContext _db = new ContosoMedicalDataClassesDataContext();

        private ServiceHttpClient _client = new ServiceHttpClient("http://prescriptionmanagerservices20171201025306.azurewebsites.net");

        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            DisplayPatients();
        }

        private void patientsGridView_SelectionChanged(object sender, EventArgs e)
        {
            DisplayPrescriptions();
        }

        #endregion

        #region View by Patient tab - display data

        private async void DisplayPatients()
        {
            //var servicePatient = await _client.GetById<Patients>("api/Patients", 1);
            var servicePatients = await _client.Get<List<Patients>>("api/Patients");
            // Get all patients from the database, and display them.
            //foreach (Patient p in _db.Patients)
            //{
            //    string patientName = p.FirstName + " " + p.LastName;
            //    patientsGridView.Rows.Add(p.PatientID, patientName);
            //}
            foreach (var p in servicePatients)
            {
                string patientName = p.FirstName + " " + p.LastName;
                patientsGridView.Rows.Add(p.PatientId, patientName);
            }

        }

        private async void DisplayPrescriptions()
        {
            // Clear the prescriptionsGridView.
            prescriptionsGridView.Rows.Clear();

            // Get the highlighted patient ID in the patientsGridView.
            int patientID = (int)patientsGridView.CurrentRow.Cells["PatientID"].Value;

#region Old Linq to SQL code
            // Define a LINQ query to get the prescriptions for the patient.
            //var query = from prescription in _db.Prescriptions
            //            where prescription.PatientID == patientID
            //            select prescription;

            // Display the prescriptions.
            //foreach (Prescription p in query)
            //{
            //    prescriptionsGridView.Rows.Add(p.PrescriptionID, 
            //                                   p.Description, 
            //                                   p.IssueDate.ToShortDateString(), 
            //                                   p.RepeatCount);
            //}
#endregion
            
            var servicePrescriptions = await _client.Get<List<Prescriptions>>($"api/Patients/{patientID}/Prescriptions");
            foreach (var p in servicePrescriptions)
            {
                prescriptionsGridView.Rows.Add(p.PrescriptionId,
                                               p.Description,
                                               p.IssueDate.ToShortDateString(),
                                               p.RepeatCount);
            }



            // Highlight the first row in the prescriptionsGridView.
            if (prescriptionsGridView.Rows.Count != 0)
            {
                prescriptionsGridView.CurrentCell = prescriptionsGridView[0, 0];
            }
        }
        
        #endregion

        #region View by Patient tab - modify data

        //private Prescription GetPrescriptionEntity(int prescriptionID)
        //{
        //    // Define a LINQ query to get the specified Prescription entity.
        //    var query = from p in _db.Prescriptions
        //                where p.PrescriptionID == prescriptionID
        //                select p;

        //    // Return the Prescription entity.
        //    return query.First();
        //}

        private async void repeatPrescriptions_Click(object sender, EventArgs e)
        {
            // Get the highlighted prescriptions in the prescriptionsGridView.
            DataGridViewSelectedRowCollection selectedRows = prescriptionsGridView.SelectedRows;

            // For each highlighted prescription, increase the RepeatCount.
            for (int i = 0; i < selectedRows.Count; i++)
            {
                // Get the PrescriptionID from the prescriptionsGridView row.
                int prescriptionID = (int)selectedRows[i].Cells["PrescriptionID"].Value;

                // Get the Prescription entity.
                //Prescription prescription = GetPrescriptionEntity(prescriptionID);
                var prescription = await _client.GetById<Prescriptions>("/api/Prescriptions", prescriptionID);

                // Increment the RepeatCount.
                prescription.RepeatCount++;

                await _client.Put("/api/Prescriptions", prescription, prescriptionID);
            }

            // Save the changes to the database.
            //DoSave();
            DisplayPrescriptions();
        }

        private async void deletePrescriptions_Click(object sender, EventArgs e)
        {
            // Get the highlighted prescriptions in the prescriptionsGridView.
            DataGridViewSelectedRowCollection selectedRows = prescriptionsGridView.SelectedRows;

            // For each highlighted prescription, delete it.
            for (int i = 0; i < selectedRows.Count; i++)
            {
                // Get the PrescriptionID from the prescriptionsGridView row.
                int prescriptionID = (int)selectedRows[i].Cells["PrescriptionID"].Value;

                // Get the Prescription entity.
                //Prescription prescription = GetPrescriptionEntity(prescriptionID);

                // Delete the Prescription entity.
                //_db.Prescriptions.DeleteOnSubmit(prescription);
                await _client.Delete<Prescriptions>("/api/Prescriptions", prescriptionID);

            }

            // Save the changes to the database.
            //DoSave();
            DisplayPrescriptions();
        }

        private void newPrescriptions_Click(object sender, EventArgs e)
        {
            // Get the highlighted patient ID in the patientsGridView.
            int patientID = (int)patientsGridView.CurrentRow.Cells["PatientID"].Value;

            // Display a form to add new prescriptions.
            //NewPrescriptionsForm form = new NewPrescriptionsForm(patientID, _db);
            NewPrescriptionsForm form = new NewPrescriptionsForm(patientID, _client);
            form.ShowDialog();

            // Save the changes to the database.
            //DoSave();
            DisplayPrescriptions();
        }

        //private void DoSave()
        //{
        //    try
        //    {
        //        // Submit changes to the database.
        //        _db.SubmitChanges(ConflictMode.ContinueOnConflict);
        //    }
        //    catch (ChangeConflictException)
        //    {
        //        // Iterate over concurrency conflicts.
        //        foreach (ObjectChangeConflict occ in _db.ChangeConflicts)
        //        {
        //            // Get the Prescription entity in conflict.
        //            Prescription entityInConflict = (Prescription)occ.Object;
        //            string caption = string.Format("Prescription ID {0} - Conflicting Updates Not Saved", entityInConflict.PrescriptionID);

        //            // For each member in conflict, get the current, original, and database values.
        //            string message = string.Empty;
        //            foreach (MemberChangeConflict mcc in occ.MemberConflicts)
        //            {
        //                message += string.Format("Member in conflict: {0}\n",   mcc.Member);
        //                message += string.Format("  - current value:  {0}\n",   mcc.CurrentValue);
        //                message += string.Format("  - original value: {0}\n",   mcc.OriginalValue);
        //                message += string.Format("  - database value: {0}\n\n", mcc.DatabaseValue);
        //            }
        //            MessageBox.Show(message, caption, MessageBoxButtons.OK, MessageBoxIcon.Warning);

        //            // Override all the current values with the values from the database.
        //            occ.Resolve(RefreshMode.OverwriteCurrentValues);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        MessageBox.Show(ex.Message, "Exception Occurred", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        //    }

        //    // Redisplay the prescriptions.
        //    DisplayPrescriptions();
        //}

        #endregion

        #region View by Date tab - display data

        private async void go_Click(object sender, EventArgs e)
        {
            // Clear the prescriptionsInPeriodGridView.
            prescriptionsInPeriodGridView.Rows.Clear();

            // Get the dates specified by the user.
            DateTime fromDate = fromDatePicker.Value.Date;
            DateTime toDate = toDatePicker.Value.Date;

            // Define a LINQ query to get Prescription entities in the date range.
            //var query = from p in _db.Prescriptions
            //            where p.IssueDate >= fromDate && p.IssueDate <= toDate 
            //            orderby p.IssueDate
            //            select p;

            //// Display the Prescription entities.
            //foreach (Prescription p in query)
            //{
            //    string patientName = p.Patient.FirstName + " " + p.Patient.LastName;
            //    prescriptionsInPeriodGridView.Rows.Add(p.PrescriptionID,
            //                                           p.IssueDate.ToShortDateString(),
            //                                           patientName,
            //                                           p.Description,
            //                                           p.RepeatCount);
            //}

            var results = await _client.Get<List<Prescriptions>>("/api/Prescriptions",
                new[] {(key: "fromDate", value: fromDate.ToString()), (key: "toDate", value: toDate.ToString())});
            foreach (var p in results)
            {
                string patientName = p.Patient.FirstName + " " + p.Patient.LastName;
                prescriptionsInPeriodGridView.Rows.Add(p.PrescriptionId,
                                                       p.IssueDate.ToShortDateString(),
                                                       patientName,
                                                       p.Description,
                                                       p.RepeatCount);
            }

        }

        #endregion
    }
}
