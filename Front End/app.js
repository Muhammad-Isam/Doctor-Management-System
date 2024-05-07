const currentPageName = window.location.pathname.split("/").pop();
let doctor

// const fetchBtn = document.getElementById("fetchBtn")
// fetch('http://localhost:3000/')
//             .then(response => {
//                 if (!response.ok) {
//                     throw new Error('Network response was not ok');
//                 }
//                 return response.json(); // Parse response as JSON
//             })
//             .then(data => {
//                 // Get the div where you want to display the data
//                 var dataDiv = document.getElementById('data');

//                 // Iterate through the data and create HTML elements to display it
//                 console.log(data)
//                 data.forEach(doctor => {
//                     console.log(doctor)
//                     // var employeeInfo = document.createElement('p');
//                     // employeeInfo.textContent = doctor.DoctorID + ' ' + doctor.Specialization;
//                     // dataDiv.appendChild(employeeInfo);
//                 });
//             })
//             .catch(error => {
//                 console.error('Error fetching data:', error);
//                 // Handle non-JSON response here
//                 // For example, you can display an error message in the data div
//                 // var dataDiv = document.getElementById('data');
//                 // dataDiv.textContent = 'Error fetching data: ' + error.message;
//             });


// Add event listener to the fetch button
// fetchBtn.addEventListener("click", fetchDoctorDetails);

async function fetchDoctorDetails() {
    var email = "aisha@example.com";
    var password = "password4";
    var url = 'http://localhost:3000/doctor?email=' + encodeURIComponent(email) + '&password=' + encodeURIComponent(password);
    console.log(url)
    try {
        const response = await fetch(url);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const doctorDetails = await response.json();
        doctor = doctorDetails;
        console.log(doctor)     
        if (currentPageName === "personalinfo.html") {
            displayDoctorProfile();
          }
        else if (currentPageName === "appointment.html")
            {
                updateAppointmentsTable();
            }
            else if (currentPageName === "diagnosis.html") 
                {
                    updateDiagnosesTable();
                }   
        } catch (error) {
        console.error('Error fetching doctor details:', error);
    }
}
fetchDoctorDetails();

async function displayDoctorProfile() {
    try {
        if (doctor) {
            var doctorDays = '';
            doctor.forEach(function(day) {
                doctorDays += day.Day + ' ';
            });
            document.getElementById("name").value = doctor[0].DoctorName;
            document.getElementById("gender").value = doctor[0].Gender;
            document.getElementById("dob").value = doctor[0].DoctorName;
            document.getElementById("email").value = doctor[0].Email;
            document.getElementById("specialisation").value = doctor[0].Specialization;
            document.getElementById("salary").value = doctor[0].Salary;
            document.getElementById("contactNo").value = doctor[0].Contact;
            document.getElementById("address").value = doctor[0].Address;
            document.getElementById("days").value = doctorDays;
            document.getElementById("charges").value = doctor[0].OPDCharges;
        }
    } catch (error) {
        console.error('Error displaying doctor profile:', error);
    }
}

// Function to fetch doctor appointments from the server
async function getDoctorAppointments() {
    try {
        const response = await fetch(`http://localhost:3000/appointments?doctorID=${doctor[0].DoctorID}`);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const appointments = await response.json();
        return appointments;
    } catch (error) {
        console.error('Error fetching appointments:', error);
        throw error; // Rethrow the error to be caught by the caller
    }
}

async function getMyPatientDiagnoses() {
    try {
        const response = await fetch(`http://localhost:3000/patient/diagnoses?doctorID=${doctor[0].DoctorID}`);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const patientDiagnoses = await response.json();
        return patientDiagnoses;
    } catch (error) {
        console.error('Error fetching appointments:', error);
        throw error; // Rethrow the error to be caught by the caller
    }
}

async function getPatientWithMedicalHistory(patientID) {
    try {
        const response = await fetch(`http://localhost:3000/patient?patientID=${patientID}`);
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        const patientDetails = await response.json();
        return patientDetails;
    } catch (error) {
        console.error('Error fetching patient details with medical history:', error);
        throw error; // Rethrow the error to be caught by the caller
    }
}




if (currentPageName === "patientinfo.html")
    {
        document.addEventListener("DOMContentLoaded", function() {
            // Retrieve patient details from localStorage
            const patientDetails = JSON.parse(localStorage.getItem('patientDetails'));
            if (patientDetails) {
                // Use patient details to display information on the page
                console.log(patientDetails);
                document.getElementById("pName").value = patientDetails[0].PatientName;
                document.getElementById("pGender").innerText = patientDetails[0].Gender;
                document.getElementById("pDOB").innerText = patientDetails[0].DOB;
                document.getElementById("pEmail").innerText = patientDetails[0].Email;
                document.getElementById("pContact").innerText = patientDetails[0].Contact;
                document.getElementById("pAddress").innerText = patientDetails[0].Address;
                document.getElementById("pSurgeries").innerText = patientDetails[0].PreviousSurgeries;
                document.getElementById("pFH").innerText = patientDetails[0].FamilyHistory;
                document.getElementById("pTH").innerText = patientDetails[0].TreatmentHistory;
                document.getElementById("pAllergies").innerText = patientDetails[0].Allergies;
                // Clear patient details from localStorage (optional)
                localStorage.removeItem('patientDetails');
            } else {
                console.error('Patient details not found in localStorage.');
            }
        });
    }

async function updateAppointmentsTable() {
    try {
        // Check if doctor object is defined
        if (!doctor || !doctor[0] || !doctor[0].DoctorID) {
            throw new Error('Doctor details not available');
        }

        // Fetch doctor appointments asynchronously
        const appointments = await getDoctorAppointments();
        console.log(appointments)
        // Get the table body element
        var tbody = document.querySelector('table tbody');

        // Clear existing rows
        tbody.innerHTML = '';

        // Loop through appointments and add rows to the table
        appointments.forEach(function(appointment) {
            // Create a new table row
            var row = document.createElement('tr');

            // Create table data cells for each appointment property
            var idCell = document.createElement('td');
            idCell.textContent = appointment.AppointmentID;
            row.appendChild(idCell);

            var nameCell = document.createElement('td');
            nameCell.textContent = appointment.PatientName;
            row.appendChild(nameCell);

            var dateCell = document.createElement('td');
            dateCell.textContent = appointment.Date;
            row.appendChild(dateCell);

            var timeCell = document.createElement('td');
            timeCell.textContent = appointment.Time;
            row.appendChild(timeCell);

            var statusCell = document.createElement('td');
            statusCell.textContent = appointment.Status;
            row.appendChild(statusCell);

            var profileCell = document.createElement('td');
            var viewButton = document.createElement('button');
            viewButton.textContent = 'View';
            viewButton.setAttribute('PatientID', appointment.PatientID)
            viewButton.classList.add('btn', 'btn-active', 'btn-accent');
            // Add event listener to view button
            viewButton.addEventListener('click', async function() {
                try {
                    const patientID = this.getAttribute('PatientID');
                    const patientDetails = await getPatientWithMedicalHistory(patientID);
                    // Store patient details in localStorage
                    localStorage.setItem('patientDetails', JSON.stringify(patientDetails));
                    // Redirect to patientinfo.html
                    window.location.pathname = "patientinfo.html";
                    
                } catch (error) {
                    console.error('Error fetching patient details:', error);
                }
            });
            profileCell.appendChild(viewButton);
            row.appendChild(profileCell);

            // Append the row to the table body
            tbody.appendChild(row);
        });
    } catch (error) {
        console.error('Error updating appointments table:', error);
    }
}

async function updateDiagnosesTable() {
    try {
        // Check if doctor object is defined
        if (!doctor || !doctor[0] || !doctor[0].DoctorID) {
            throw new Error('Doctor details not available');
        }

        // Fetch doctor diagnoses asynchronously
        const diagnoses = await getMyPatientDiagnoses();
        console.log(diagnoses);

        // Get the table body element
        var tbody = document.querySelector('table tbody');

        // Clear existing rows
        tbody.innerHTML = '';

        // Loop through diagnoses and add rows to the table
        diagnoses.forEach(function(diagnosis) {
            // Create a new table row
            var row = document.createElement('tr');

            // Create table data cells for each diagnosis property
            var nameCell = document.createElement('td');
            nameCell.textContent = diagnosis.DiagnosisName;
            row.appendChild(nameCell);

            var patientCell = document.createElement('td');
            patientCell.textContent = diagnosis.PatientName;
            row.appendChild(patientCell);

            var descriptionCell = document.createElement('td');
            descriptionCell.textContent = diagnosis.Description;
            row.appendChild(descriptionCell);

            var dateCell = document.createElement('td');
            dateCell.textContent = diagnosis.Date;
            row.appendChild(dateCell);

            var prescriptionCell = document.createElement('td');
            var viewButton = document.createElement('button');
            viewButton.textContent = 'View';
            viewButton.setAttribute('DiagnosisID', diagnosis.DiagnosisID);
            viewButton.classList.add('btn', 'btn-active', 'btn-accent');
            // Add event listener to view button
            viewButton.addEventListener('click', async function() {
                try {
                    const diagnosisID = this.getAttribute('DiagnosisID');
                    const diagnosisDetails = await getDiagnosisDetails(diagnosisID);
                    // Store diagnosis details in localStorage
                    localStorage.setItem('diagnosisDetails', JSON.stringify(diagnosisDetails));
                    // Redirect to diagnosisinfo.html
                    window.location.pathname = "diagnosisinfo.html";
                    
                } catch (error) {
                    console.error('Error fetching diagnosis details:', error);
                }
            });
            prescriptionCell.appendChild(viewButton);
            row.appendChild(prescriptionCell);

            // Append the row to the table body
            tbody.appendChild(row);
        });
    } catch (error) {
        console.error('Error updating diagnoses table:', error);
    }
}


// Call the function to update the table when the page loads


// console.log(currentPageName)
