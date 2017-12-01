using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace PrescriptionManagerServices.Models
{
    public partial class ContosoMedicalDBContext : DbContext
    {
        public virtual DbSet<Appointments> Appointments { get; set; }
        public virtual DbSet<Doctors> Doctors { get; set; }
        public virtual DbSet<Patients> Patients { get; set; }
        public virtual DbSet<Prescriptions> Prescriptions { get; set; }

        // Unable to generate entity type for table 'dbo.ArchivedPatients'. Please see the warning messages.

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer(@"Server=tcp:surveycollector.database.windows.net,1433;Initial Catalog=ContosoMedicalDB;Persist Security Info=False;User ID=scadmin;Password=P2ssw0rd;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Appointments>(entity =>
            {
                entity.HasKey(e => e.AppointmentId);

                entity.Property(e => e.AppointmentId).HasColumnName("AppointmentID");

                entity.Property(e => e.AppointmentDateTime).HasColumnType("datetime");

                entity.Property(e => e.DoctorId).HasColumnName("DoctorID");

                entity.Property(e => e.Notes)
                    .HasMaxLength(500)
                    .HasDefaultValueSql("(N'No notes.')");

                entity.Property(e => e.PatientId).HasColumnName("PatientID");

                entity.HasOne(d => d.Doctor)
                    .WithMany(p => p.Appointments)
                    .HasForeignKey(d => d.DoctorId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Appointments_Doctors");

                entity.HasOne(d => d.Patient)
                    .WithMany(p => p.Appointments)
                    .HasForeignKey(d => d.PatientId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Appointments_Patients");
            });

            modelBuilder.Entity<Doctors>(entity =>
            {
                entity.HasKey(e => e.DoctorId);

                entity.Property(e => e.DoctorId).HasColumnName("DoctorID");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.Specialty)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<Patients>(entity =>
            {
                entity.HasKey(e => e.PatientId);

                entity.Property(e => e.PatientId).HasColumnName("PatientID");

                entity.Property(e => e.DateOfBirth).HasColumnType("datetime");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(30);

                entity.Property(e => e.Gender)
                    .IsRequired()
                    .HasColumnType("char(1)");

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasMaxLength(30);
            });

            modelBuilder.Entity<Prescriptions>(entity =>
            {
                entity.HasKey(e => e.PrescriptionId);

                entity.Property(e => e.PrescriptionId).HasColumnName("PrescriptionID");

                entity.Property(e => e.Description)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.IssueDate).HasColumnType("datetime");

                entity.Property(e => e.PatientId).HasColumnName("PatientID");
            });
        }
    }
}
