const currentPageName = window.location.pathname.split("/").pop();
let doctor
let searchBtn = document.getElementById("search");
const invoiceDiv = document.getElementsByClassName("invoice")[0]
const loginBtn = document.getElementById("signin")

if (invoiceDiv) {
    invoiceDiv.style.display = "none";

}
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

let genBtn = document.getElementById("gen")

async function fetchDoctorDetails(email, password) {
    // var email = "ali@example.com";
    // var password = "password1";
    // var email = "aisha@example.com";
    // var password = "password4";
    var url = 'http://localhost:3000/doctor?email=' + encodeURIComponent(email) + '&password=' + encodeURIComponent(password);
    console.log(url)
    try {
        const response = await fetch(url);
        if (!response.ok) {
            return alert("Invalid Credentials!");
            // throw new Error('Network response was not ok');
        }
        const doctorDetails = await response.json();
        doctor = doctorDetails;
        console.log(doctor)
        localStorage.setItem('doctor', JSON.stringify(doctor));
        window.location.pathname="index.html"


    } catch (error) {
        console.error('Error fetching doctor details:', error);
    }
}
// fetchDoctorDetails();
doctor=JSON.parse(localStorage.getItem('doctor'))

async function displayDoctorProfile() {
    try {
        if (doctor) {
            var doctorDays = '';
            doctor.forEach(function (day) {
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

searchBtn && searchBtn.addEventListener('click', async () => {
    const appointmentID = document.getElementById('appID').value
    const testID = document.getElementById('testID').value
    console.log(appointmentID + testID)
    if (appointmentID.length > 0 && testID.length > 0) {
        invoiceDiv.style.display = "inline-block";
        const patientLabDetails = await getPatientLabDetails(appointmentID, testID)
        console.log(patientLabDetails)
        console.log(patientLabDetails[0].PatientName)
        document.getElementById('pName').innerText = patientLabDetails[0].PatientName
        document.getElementById('page').innerText = patientLabDetails[0].Age
        document.getElementById('date').innerText = patientLabDetails[0].TestResultSchedule.toString().substring(0, 10)
        document.getElementById('dName').innerText = 'Dr. ' + patientLabDetails[0].DoctorName
        var tbody = document.querySelector('table tbody');
        tbody.innerHTML = '';

        patientLabDetails.forEach(detail => {
            var row = document.createElement('tr');

            // Create table data cells for each lab test detail property
            var idCell = document.createElement('td');
            idCell.textContent = detail.TestID;
            row.appendChild(idCell);

            var nameCell = document.createElement('td');
            nameCell.textContent = detail.TestName;
            row.appendChild(nameCell);

            var fieldCell = document.createElement('td');
            fieldCell.textContent = detail.FieldName;
            row.appendChild(fieldCell);

            var resultCell = document.createElement('td');
            resultCell.textContent = detail.FieldResult;
            row.appendChild(resultCell);

            var normalCell = document.createElement('td');
            normalCell.textContent = detail.NormalRange;
            row.appendChild(normalCell);

            // Append the row to the table body
            tbody.appendChild(row);
        });
    }
    else {
        alert("Please fill both the fields!")
    }
});

async function getPatientLabDetails(appointmentID, testID) {
    // Send a GET request to the server with the patient ID as a query parameter
    try {
        const response = await fetch(`http://localhost:3000/patient/lab/details?appointmentID=${appointmentID}&testID=${testID}`)

        if (!response.ok) {
            // If the response is not successful, throw an error
            alert("Error! Such record does not exist!")
            // throw new Error('Failed to fetch prescription details');
        }

        // Parse the response body as JSON
        const patientLabDetails = await response.json();
        console.log(patientLabDetails)
        // Return the prescription details
        return patientLabDetails;
    } catch (error) {
        // Log any errors to the console
        console.error('Error fetching prescription details:', error);
        // Throw the error to be handled by the caller
        throw error;
    }
}
async function getPrescriptionDetails(appointmentID) {
    try {
        // Make a GET request to the server endpoint with the appointmentID as a query parameter
        const response = await fetch(`http://localhost:3000/prescription/details?appointmentID=${appointmentID}`);

        // Check if the response is successful
        if (!response.ok) {
            // If the response is not successful, throw an error
            throw new Error('Failed to fetch prescription details');
        }

        // Parse the response body as JSON
        const prescriptionDetails = await response.json();
        console.log(prescriptionDetails)
        // Return the prescription details
        return prescriptionDetails;
    } catch (error) {
        // Log any errors to the console
        console.error('Error fetching prescription details:', error);
        // Throw the error to be handled by the caller
        throw error;
    }
}

async function displayPrescriptionDetails() {
    const prescriptionDetails = JSON.parse(localStorage.getItem('prescriptionDetails'));
    console.log(prescriptionDetails)
    // console.log(prescriptionDetails.length)

    let medContainer = document.getElementById("medication-info")
    let testContainer = document.getElementById("test-info")
    function addMedField() {
        medContainer.innerHTML += `<br>` + `                    <label for="medicine">Medicine:</label>
        <input type="text" class="medi" id="medi" placeholder="Panadol" readonly>
        <label for="Dose">Dose: </label>
        <input type="text" id="Dose2" class="Dose2" placeholder="250m/l" readonly>
        <label for="Dose">Quantity: </label>
        <input type="text" id="qty2" class="qty2" placeholder="1/2/3" readonly>
        <label for="Frequency">Frequency: </label>
        <input type="text" id="freq" class="freq" placeholder="Twice a day" readonly>
        <label for="Duration" id="dur2">Duration: </label>
        <input type="text" id="duration2" class="duration2" placeholder="in (days)" readonly>
        <br><label for="clinical-notes">Instructions:</label>
        <textarea class="textarea textarea-ghost ins" class="ins" id="ins" placeholder="Notes" readonly></textarea>`
    }
    let j = 1;

    function addTestField() {
        testContainer.innerHTML += `<br>` + `                    <label for="test">Test:</label>
        <input type="text" id="tst" placeholder="CBC" readonly>`;
    }

    for (let i = 1; i < prescriptionDetails.length; i++) {
        if ((prescriptionDetails[i].Testname != null) && (prescriptionDetails[i].Testname != prescriptionDetails[j].Testname) && (j < prescriptionDetails.length)) {
            // console.log(i)
            addTestField();
        }
        addMedField();
    }

    const selectElements = document.querySelectorAll('.medi');
    const testSelectElements = document.querySelectorAll('.tst');
    const freqElements = document.querySelectorAll('.freq')
    const doseElements = document.querySelectorAll('.Dose2')
    const insElements = document.querySelectorAll('.ins')
    const durElements = document.querySelectorAll('.duration2')
    const qtyElements = document.querySelectorAll('.qty2')
    document.getElementById("app-id").value = prescriptionDetails[0].AppointmentID;
    document.getElementById("patient-id").value = prescriptionDetails[0].PatientName;
    document.getElementById("age").value = prescriptionDetails[0].Age;
    document.getElementById("doctor-name").value = doctor[0].DoctorName;
    document.getElementById("cnotes").value = prescriptionDetails[0].ClinicalNotes;
    document.getElementById("description").value = prescriptionDetails[0].Description;
    document.getElementById("diag").value = prescriptionDetails[0].DiagnosisName;

    for (let i = 0; i < prescriptionDetails.length; i++) {
        // console.log(selectElements)
        selectElements[i].value = prescriptionDetails[i].MedicineName
        freqElements[i].value = prescriptionDetails[i].Frequency
        doseElements[i].value = prescriptionDetails[i].Dosage
        qtyElements[i].value = prescriptionDetails[i].Quantity
        durElements[i].value = prescriptionDetails[i].MedicineDuration
        insElements[i].value = prescriptionDetails[i].Instructions
    }
    for (let i = 0; i < testSelectElements.length; i++) {
        if ((prescriptionDetails[i].Testname != null)) {
            console.log(prescriptionDetails[i].Testname)
            testSelectElements[i].value = prescriptionDetails[i].Testname
        }
        j++
    }
    localStorage.removeItem('prescriptionDetails');

}

// Function to fetch doctor appointments from the server
async function getDoctorAppointments() {
    try {
        const response = await fetch(`http://localhost:3000/appointments?doctorID=${doctor[0].DoctorID}`);
        if (!response.ok) {
            // throw new Error('Network response was not ok');
            var tbody = document.querySelector('table tbody');
            tbody.innerHTML = '<td></td><td></td><td></td><td></td><td>NO APPOINTMENTS!</td><td></td><td></td><td></td>';
        }
        const appointments = await response.json();
        return appointments;
    } catch (error) {
        console.error('Error fetching appointments:', error);
        throw error; // Rethrow the error to be caught by the caller
    }
}
async function getPastAppointments() {
    try {
        const response = await fetch(`http://localhost:3000/appointments/past/?doctorID=${doctor[0].DoctorID}`);
        if (!response.ok) {
            // throw new Error('Network response was not ok');
            var tbody = document.querySelector('table tbody');
            tbody.innerHTML = '<td></td><td></td><td></td><td></td><td>NO APPOINTMENTS!</td><td></td>';
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
            var tbody = document.querySelector('table tbody');
            tbody.innerHTML = '<td></td><td></td><td></td><td></td><td>NO DIAGNOSES YET!</td><td></td><td></td><td></td>';
            // throw new Error('Network response was not ok');
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

async function updateAppointmentStatus(appointmentID, status) {
    try {
        const response = await fetch(`http://localhost:3000/update-appointment-status/${appointmentID}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ status: status })
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const result = await response.text();
        return result;
    } catch (error) {
        console.error('Error updating appointment status:', error);
        throw error; // Rethrow the error to be caught by the caller
    }
}

// updateAppointmentStatus(2, 'Confirmed')

if (currentPageName === "patientinfo.html") {
    document.addEventListener("DOMContentLoaded", function () {
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

async function updatePastAppointmentsTable() {
    try {
        // Fetch past appointments asynchronously
        const pastAppointments = await getPastAppointments();

        // Get the table body element
        var tbody = document.querySelector('table tbody');

        // Clear existing rows
        tbody.innerHTML = '';

        // Loop through past appointments and add rows to the table
        pastAppointments.forEach(function (appointment) {
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

            // Create a cell for the "Prescription" button
            var prescriptionCell = document.createElement('td');
            var prescriptionButton = document.createElement('button');
            prescriptionButton.textContent = 'Prescription';
            prescriptionButton.setAttribute('AppointmentID', appointment.AppointmentID)
            prescriptionButton.classList.add('btn', 'btn-active', 'btn-accent');
            // Add event listener to prescription button
            prescriptionButton.addEventListener('click', async function () {
                try {
                    const appointmentID = this.getAttribute('AppointmentID');
                    // Fetch patient details for prescription generation
                    let patientDetails = await getPatientWithMedicalHistory(appointmentID);
                    // Store patient details in localStorage
                    const patientData = {
                        appointmentID: appointment.AppointmentID,
                        patientDetails: patientDetails
                    };
                    // Store patient data in localStorage
                    localStorage.setItem('patientData', JSON.stringify(patientData));
                    // Redirect to prescription.html
                    const prescriptionDetails = await getPrescriptionDetails(appointmentID);
                    localStorage.setItem('prescriptionDetails', JSON.stringify(prescriptionDetails));
                    window.location.pathname = "viewprescription.html";

                } catch (error) {
                    console.error('Error fetching patient details for prescription:', error);
                }
            });
            prescriptionCell.appendChild(prescriptionButton);
            row.appendChild(prescriptionCell);

            // Append the row to the table body
            tbody.appendChild(row);
        });
    } catch (error) {
        console.error('Error updating past appointments table:', error);
    }
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
        appointments.forEach(function (appointment) {
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
            viewButton.addEventListener('click', async function () {
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

            // Create a cell for the "Generate Prescription" button
            var prescriptionCell = document.createElement('td');
            var prescriptionButton = document.createElement('button');
            prescriptionButton.textContent = 'Prescription';
            prescriptionButton.setAttribute('PatientID', appointment.PatientID)
            prescriptionButton.setAttribute('AppointmentID', appointment.AppointmentID)
            prescriptionButton.classList.add('btn', 'btn-active', 'btn-accent');
            // Add event listener to prescription button
            prescriptionButton.addEventListener('click', async function () {
                try {
                    const patientID = this.getAttribute('PatientID');
                    // Fetch patient details for prescription generation
                    let patientDetails = await getPatientWithMedicalHistory(patientID);
                    // Store patient details in localStorage
                    const patientData = {
                        appointmentID: appointment.AppointmentID,
                        patientDetails: patientDetails
                    };
                    // Store patient data in localStorage
                    localStorage.setItem('patientData', JSON.stringify(patientData));
                    // Redirect to prescription.html
                    window.location.pathname = "prescription.html";

                } catch (error) {
                    console.error('Error fetching patient details for prescription:', error);
                }
            });
            prescriptionCell.appendChild(prescriptionButton);
            row.appendChild(prescriptionCell);

            // Create a cell for the "Cancel Appointment" button
            var cancelCell = document.createElement('td');
            var cancelButton = document.createElement('button');
            cancelButton.textContent = 'Cancel';
            cancelButton.classList.add('btn', 'btn-active', 'btn-danger');
            // Add event listener to cancel button
            cancelButton.addEventListener('click', async function () {
                try {
                    // Call the updateAppointmentStatus function with the appointment ID to cancel the appointment
                    await updateAppointmentStatus(appointment.AppointmentID, 'Cancelled');
                    // Refresh the appointments table after cancelling the appointment
                    updateAppointmentsTable();
                } catch (error) {
                    console.error('Error cancelling appointment:', error);
                }
            });
            cancelCell.appendChild(cancelButton);
            row.appendChild(cancelCell);

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
        diagnoses.forEach(function (diagnosis) {
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
            viewButton.setAttribute('AppointmentID', diagnosis.AppointmentID);
            viewButton.classList.add('btn', 'btn-active', 'btn-accent');
            // Add event listener to view button
            viewButton.addEventListener('click', async function () {
                try {
                    const diagnosisID = this.getAttribute('DiagnosisID');
                    const appointmentID = this.getAttribute('AppointmentID');
                    const prescriptionDetails = await getPrescriptionDetails(appointmentID);
                    localStorage.setItem('prescriptionDetails', JSON.stringify(prescriptionDetails));
                    window.location.pathname = "viewprescription.html";

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

let medicines;
let totalLabTests;
async function fetchDiagnosis() {
    try {
        const response = await fetch('http://localhost:3000/diagnosis');

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const diagnosis = await response.json();
        // console.log('Diagnosis:', diagnosis);

        return diagnosis;
    } catch (error) {
        console.error('Error fetching medicines:', error);
        throw error;
    }
}
async function fetchMedicines() {
    try {
        const response = await fetch('http://localhost:3000/medicines');

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const medicines = await response.json();
        // console.log('Medicines:', medicines);

        return medicines;
    } catch (error) {
        console.error('Error fetching medicines:', error);
        throw error;
    }
}
async function fetchTotalLabTests() {
    try {
        const response = await fetch('http://localhost:3000/total-lab-tests');

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const totalLabTests = await response.json();
        // console.log('Total Lab Tests:', totalLabTests);
        return totalLabTests;
    } catch (error) {
        console.error('Error fetching total lab tests:', error);
        throw error;
    }
}

// Example usage


function updateMedicineOptions(medicines) {
    // Get the select element
    const selectElement = document.getElementById('medicine');

    // Clear existing options
    selectElement.innerHTML = '';

    // Add new options for each medicine
    medicines.forEach(medicine => {
        const option = document.createElement('option');
        option.value = medicine.MedicineID; // Assuming MedicineID is the property containing the unique identifier for the medicine
        option.textContent = medicine.MedicineName; // Assuming MedicineName is the property containing the name of the medicine
        selectElement.appendChild(option);
    });
}




function updateTestOptions(totalLabTests) {
    // Get the select element
    const selectElement = document.getElementById('test');

    // Clear existing options
    selectElement.innerHTML = '';

    // Add new options for each test
    totalLabTests.forEach(test => {
        const option = document.createElement('option');
        option.value = test.TestID; // Assuming TestID is the property containing the unique identifier for the test
        option.textContent = test.Testname; // Assuming Testname is the property containing the name of the test
        selectElement.appendChild(option);
    });
}

function updateDiagnosisOptions(diagnosis) {
    // Get the select element
    const selectElement = document.getElementById('diagnosis');

    // Clear existing options
    selectElement.innerHTML = '';

    // Add new options for each medicine
    diagnosis.forEach(diagnosis => {
        const option = document.createElement('option');
        option.value = diagnosis.DiagnosisID; // Assuming MedicineID is the property containing the unique identifier for the medicine
        option.textContent = diagnosis.DiagnosisName; // Assuming MedicineName is the property containing the name of the medicine
        selectElement.appendChild(option);
    });
}


genBtn = document.getElementById("gen");


function generatePrescription() {
    // Get all select elements with the class 'medicine'
    // Get all select elements with the class 'medicine'
    const selectElements = document.querySelectorAll('.medicine');
    const testSelectElements = document.querySelectorAll('.test');
    const freqElements = document.querySelectorAll('.freq')
    const doseElements = document.querySelectorAll('.Dose')
    const insElements = document.querySelectorAll('.ins')
    const durElements = document.querySelectorAll('.duration')
    const qtyElements = document.querySelectorAll('.qty')
    // Initialize an array to store the selected values
    const selectedValues = [];
    const testSelectedValues = [];
    const freqSelectedValues = [];
    const doseSelectedValues = [];
    const insSelectedValues = [];
    const durSelectedValues = [];
    const qtySelectedValues = [];
    // Loop through each select element
    selectElements.forEach(selectElement => {
        // Get the selected value of each select element
        const selectedValue = selectElement.value;

        // Push the selected value to the array
        selectedValues.push(selectedValue);
    });

    qtyElements.forEach(qtyElements => {
        const qtySelectedValue = qtyElements.value;
        qtySelectedValues.push(qtySelectedValue);
    });

    doseElements.forEach(doseElements => {
        const doseSelectedValue = doseElements.value;
        doseSelectedValues.push(doseSelectedValue);
    });

    insElements.forEach(insElements => {
        const insSelectedValue = insElements.value;
        insSelectedValues.push(insSelectedValue);
    });

    durElements.forEach(durElements => {
        const durSelectedValue = durElements.value;
        durSelectedValues.push(durSelectedValue);
    });

    freqElements.forEach(freqElements => {
        const freqSelectedValue = freqElements.value;
        freqSelectedValues.push(freqSelectedValue);
    });

    testSelectElements.forEach(testSelectElement => {
        // Get the selected value of each select element
        const selectedValue = testSelectElement.value;

        // Push the selected value to the array
        testSelectedValues.push(selectedValue);
    });
    console.log(selectedValues);
    console.log(testSelectedValues)
    console.log(durSelectedValues)
    console.log(insSelectedValues)
    console.log(freqSelectedValues)
    console.log(doseSelectedValues)
    console.log(qtySelectedValues)

    diagnosisSelectElement = document.getElementById('diagnosis')
    const diagnosisSelectedValue = diagnosisSelectElement.value;
    const appID = document.getElementById("app-id").value;
    const clinicalNotes = document.getElementById("cnotes").value;
    const diagnosisID = diagnosisSelectedValue;
    const description = document.getElementById("description").value;
    // createPrescription(appID, clinicalNotes, diagnosisID, description)

    for (let i = 0; i < durSelectedValues.length; i++) {
        addMedicinesToPrescription(selectedValues[i], freqSelectedValues[i], qtySelectedValues[i], doseSelectedValues[i],
            insSelectedValues[i], durSelectedValues[i]);
    }

    updateAppointmentStatus(appID, 'Confirmed')
    for (let i = 0; i < testSelectedValues.length; i++) {
        addTestToPrescription(testSelectedValues[i])
    }
    alert("Prescription Generated! Generating Bill!");
    const patientData = JSON.parse(localStorage.getItem('patientData'));

    let billData = {
        PatientID: patientData.patientDetails[0].PatientID,
        PatientName: patientData.patientDetails[0].PatientName,
        DoctorID: doctor[0].DoctorID,
        AppointmentID: appID,
        OPDCharges: doctor[0].OPDCharges
    }
    localStorage.setItem('billData', JSON.stringify(billData));
    window.location.pathname = "billing.html";


}
genBtn && genBtn.addEventListener('click', generatePrescription)

async function addTestToPrescription(testID) {
    try {
        const response = await fetch('/add-test-to-prescription', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ testID: testID })
        });

        if (!response.ok) {
            throw new Error('Failed to add test to prescription');
        }

        const result = await response.json();
        console.log('Test added to prescription successfully:', result);
        return result;
    } catch (error) {
        console.error('Error adding test to prescription:', error);
        throw error;
    }
}


async function addMedicinesToPrescription(medicineID, frequency, quantity, dosage, instructions, medicineDuration) {
    try {
        // Data to be sent in the request body
        const data = {
            medicineID: medicineID,
            frequency: frequency,
            quantity: quantity,
            dosage: dosage,
            instructions: instructions,
            medicineDuration: medicineDuration
        };

        // Send a POST request to the server
        const response = await fetch('http://localhost:3000/add-medicines-to-prescription', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        // Check if the request was successful
        if (!response.ok) {
            throw new Error('Failed to add medicines to prescription');
        }

        // Extract the result from the response
        const result = await response.json();
        console.log('Medicines added to prescription:', result);
        return result;
    } catch (error) {
        console.error('Error adding medicines to prescription:', error);
        throw error;
    }
}

async function createPrescription(appointmentID, clinicalNotes, diagnosisID, description) {
    try {
        const response = await fetch('http://localhost:3000/create-prescription', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                appointmentID: appointmentID,
                clinicalNotes: clinicalNotes,
                diagnosisID: diagnosisID,
                description: description
            })
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const result = await response.json();
        return result;
    } catch (error) {
        console.error('Error creating prescription:', error);
        throw error;
    }
}
function extractMedicationInfo() {
    // Get all medication containers
    const medicationContainers = document.querySelectorAll('.medicationContainer');

    // Initialize an array to store medication information objects
    const medicationInfoArray = [];

    // Loop through each medication container
    medicationContainers.forEach(container => {
        // Get all select elements for medicine
        const medicineSelects = container.querySelectorAll('.medicine');
        // Get the selected value of the medicine select
        const medicineID = medicineSelects[0].value;

        // Get all input elements for dose, frequency, and duration
        const doseInputs = container.querySelectorAll('.Dose');
        const frequencyInputs = container.querySelectorAll('.freq');
        const durationInputs = container.querySelectorAll('.duration');

        // Get the values of dose, frequency, and duration inputs
        const dose = doseInputs[0].value;
        const frequency = frequencyInputs[0].value;
        const duration = durationInputs[0].value;

        // Get all textarea elements for clinical notes
        const clinicalNotesTextareas = container.querySelectorAll('.textarea');

        // Get the value of the clinical notes textarea
        const clinicalNotes = clinicalNotesTextareas[0].value;

        // Create an object to store the extracted values for this medication container
        const medicationInfo = {
            medicineID: medicineID,
            dose: dose,
            frequency: frequency,
            duration: duration,
            clinicalNotes: clinicalNotes
        };

        // Push the medication information object to the array
        medicationInfoArray.push(medicationInfo);
    });

    // Return the array of medication information objects
    return medicationInfoArray;
}

if (!doctor) {
    window.location.pathname = "login.html";
}
else if (currentPageName === "personalinfo.html") {
    displayDoctorProfile();
}
else if (currentPageName === "billing.html") {
    const billData = JSON.parse(localStorage.getItem('billData'));
    console.log(doctor)
    document.getElementById("pName").innerHTML = billData.PatientName
    document.getElementById("dName").innerHTML = 'Dr. ' + doctor[0].DoctorName
    document.getElementById("opdCharges").innerHTML = 'RS' + doctor[0].OPDCharges
    document.getElementById("total").innerHTML = 'RS' + doctor[0].OPDCharges
    document.getElementById("date").innerHTML = new Date().toString().substring(4, 15)
    localStorage.removeItem('billData');

}
else if (currentPageName === "appointment.html") {
    updateAppointmentsTable();
}
else if (currentPageName === "appointmentHistory.html") {
    updatePastAppointmentsTable();
}
else if (currentPageName === "diagnosis.html") {
    updateDiagnosesTable();
}
else if (currentPageName === "viewprescription.html") {
    displayPrescriptionDetails();
}
else if (currentPageName === "prescription.html") {
    // Retrieve patient data from localStorage
    const patientData = JSON.parse(localStorage.getItem('patientData'));
    console.log(patientData);

    // Extract appointment ID and patient details from patientData
    const appointmentID = patientData.appointmentID;
    const patientDetails = patientData.patientDetails;
    console.log(patientDetails)
    // Update HTML elements with patient details
    document.getElementById("app-id").value = appointmentID;
    document.getElementById("patient-id").value = patientDetails[0].PatientName;
    document.getElementById("age").value = patientDetails[0].Age;
    document.getElementById("doctor-name").value = doctor[0].DoctorName;

    fetchMedicines()
        .then(medicines => {
            // console.log('Medicines:', medicines);
            // You can now manipulate the medicines array as needed, such as updating the options in your HTML select element
            updateMedicineOptions(medicines);
        })
        .catch(error => {
            console.error('Error fetching medicines:', error);
        });


    fetchTotalLabTests()
        .then(totalLabTests => {
            // console.log('Total Lab Tests:', totalLabTests);
            updateTestOptions(totalLabTests);
        })
        .catch(error => {
            console.error('Error fetching total lab tests:', error);
        });


    fetchDiagnosis()
        .then(diagnosis => {
            // console.log('Diagnosis:', diagnosis);
            // You can now manipulate the medicines array as needed, such as updating the options in your HTML select element
            updateDiagnosisOptions(diagnosis);
        })
        .catch(error => {
            console.error('Error fetching medicines:', error);
        });
    // localStorage.removeItem('patientData');


}

loginBtn && loginBtn.addEventListener('click', async () => {
    const email = document.getElementById("emailid").value
    const password = document.getElementById("password").value
    if (email && password) {
        fetchDoctorDetails(email, password)
    }
})
// console.log(currentPageName)

