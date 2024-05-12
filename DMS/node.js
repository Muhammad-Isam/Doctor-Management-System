var express = require('express');
var app = express();
var sql = require("mssql");
var cors = require('cors');

// Use cors middleware
app.use(cors());

// config for your database
var config = {
    server: 'localhost',
    authentication: {
        type: 'default',
        options: {
            userName: 'sa',
            password: '1234'
        }
    },
    options: {
        encrypt: true,
        trustServerCertificate: true, // Enable trust for self-signed certificate
        database: 'HospitalManagementSystem'
    }
};

app.get('/', function (req, res) {
    // connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return res.status(500).send('Internal Server Error');
        }

        console.log('Connected to database successfully');

        // create Request object
        var request = new sql.Request();

        // query to the database and get the records
        request.query('select * from Doctor', function (err, recordset) {
            if (err) {
                console.log('Error executing query:', err);
                return res.status(500).send('Internal Server Error');
            }

            // Check if there are no records
            if (!recordset.recordset || recordset.recordset.length === 0) {
                console.log('No records found');
                return res.status(404).send('No records found');
            }

            console.log('Fetched data from database:', recordset);

            // send records as a response in JSON format
            res.json(recordset.recordset);
        });
    });
});

// // Define the /user route to fetch user details
app.get('/doctor', function (req, res) {
    // Get the email and password from the query parameters
    var email = req.query.email;
    var password = req.query.password;

    // Call the getUserDetail function to fetch user details from the database
    getDoctorDetail(email, password, function(err, userDetails) {
        if (err) {
            console.error('Error fetching user details:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Check if user details were found
        if (!userDetails || userDetails.length === 0) {
            console.log('User not found');
            return res.status(404).send('User not found');
        }

        // Send the user details as JSON response
        res.json(userDetails);
    });
});

function getDoctorDetail(email, password, callback) {
    // connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // create Request object
        var request = new sql.Request();

        // Set up input parameters for the function
        request.input('Email', sql.VarChar(25), email);
        request.input('Password', sql.VarChar(25), password);

        // Execute the function
        request.query(`SELECT * FROM dbo.getDoctorDetail('${email}','${password}')`, function (err, recordset) {
            if (err) {
                console.log('Error executing query:', err);
                return callback(err, null);
            }
            console.log('Fetched user details from database:', recordset);

            callback(null, recordset.recordset);
        });
    });
}

// Define the /appointments route to fetch doctor appointments
app.get('/appointments', function (req, res) {
    // Get the DoctorID from the query parameters
    var doctorID = req.query.doctorID;

    // Call the getDoctorAppointments function to fetch appointments from the database
    getDoctorAppointments(doctorID, function(err, appointments) {
        if (err) {
            console.error('Error fetching appointments:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Check if appointments were found
        if (!appointments || appointments.length === 0) {
            console.log('Appointments not found');
            return res.status(404).send('Appointments not found');
        }

        // Send the appointments as JSON response
        res.json(appointments);
    });
});

// Define the getDoctorAppointments function
function getDoctorAppointments(doctorID, callback) {
    // connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // create Request object
        var request = new sql.Request();

        // Set up input parameters for the function
        request.input('DoctorID', sql.Int, doctorID);

        // Execute the function
        request.query(`SELECT * FROM dbo.getDoctorAppointments(${doctorID})`, function (err, recordset) {
            if (err) {
                console.log('Error executing query:', err);
                return callback(err, null);
            }
            console.log('Fetched appointments from database:', recordset);

            callback(null, recordset.recordset);
        });
    });
}

// Define the /appointments route to fetch doctor appointments
app.get('/appointments/past', function (req, res) {
    // Get the DoctorID from the query parameters
    var doctorID = req.query.doctorID;

    // Call the getDoctorAppointments function to fetch appointments from the database
    getPastAppointments(doctorID, function(err, appointments) {
        if (err) {
            console.error('Error fetching appointments:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Check if appointments were found
        if (!appointments || appointments.length === 0) {
            console.log('Appointments not found');
            return res.status(404).send('Appointments not found');
        }

        // Send the appointments as JSON response
        res.json(appointments);
    });
});

// Define the getDoctorAppointments function
function getPastAppointments(doctorID, callback) {
    // connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // create Request object
        var request = new sql.Request();

        // Set up input parameters for the function
        request.input('DoctorID', sql.Int, doctorID);

        // Execute the function
        request.query(`SELECT * FROM dbo.getPastAppointments(${doctorID})`, function (err, recordset) {
            if (err) {
                console.log('Error executing query:', err);
                return callback(err, null);
            }
            console.log('Fetched appointments from database:', recordset);

            callback(null, recordset.recordset);
        });
    });
}


// Define the /patient route to fetch patient details
app.get('/patient', function(req, res) {
    // Get the PatientID from the query parameters
    var patientID = req.query.patientID;

    // Call the getPatientWithMedicalHistory function to fetch patient details from the database
    getPatientWithMedicalHistory(patientID, function(err, patientDetails) {
        if (err) {
            console.error('Error fetching patient details:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Check if patient details were found
        if (!patientDetails || patientDetails.length === 0) {
            console.log('Patient details not found');
            return res.status(404).send('Patient details not found');
        }

        // Send the patient details as JSON response
        res.json(patientDetails);
    });
});

// Define the getPatientWithMedicalHistory function
function getPatientWithMedicalHistory(patientID, callback) {
    // connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // create Request object
        var request = new sql.Request();

        // Set up input parameters for the function
        request.input('PatientID', sql.Int, patientID);

        // Execute the function
        request.query(`SELECT * FROM dbo.getPatientWithMedicalHistory(${patientID})`, function (err, recordset) {
            if (err) {
                console.log('Error executing query:', err);
                return callback(err, null);
            }
            console.log('Fetched patient details with medical history from database:', recordset);

            callback(null, recordset.recordset);
        });
    });
}

app.get('/patient/diagnoses', function(req, res) {
    // Get the DoctorID from the query parameters
    var doctorID = req.query.doctorID;

    // Call the getPatientDiagnoses function to fetch patient diagnoses from the database
    getMyPatientDiagnoses(doctorID, function(err, patientDiagnoses) {
        if (err) {
            console.error('Error fetching patient diagnoses:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Check if patient diagnoses were found
        if (!patientDiagnoses || patientDiagnoses.length === 0) {
            console.log('Patient diagnoses not found');
            return res.status(404).send('Patient diagnoses not found');
        }

        // Send the patient diagnoses as JSON response
        res.json(patientDiagnoses);
    });
});

// Define the getPatientDiagnoses function
function getMyPatientDiagnoses(doctorID, callback) {
    // connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // create Request object
        var request = new sql.Request();

        // Set up input parameters for the function
        request.input('DoctorID', sql.Int, doctorID);

        // Execute the function
        request.query(`SELECT * FROM dbo.getMyPatientDiagnoses(${doctorID})`, function (err, recordset) {
            if (err) {
                console.log('Error executing query:', err);
                return callback(err, null);
            }
            console.log('Fetched patient diagnoses from database:', recordset);

            callback(null, recordset.recordset);
        });
    });
}

const bodyParser = require('body-parser');

app.use(bodyParser.json()); // Parse JSON-encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // Parse URL-encoded bodies

app.post('/update-appointment-status/:appointmentID', function(req, res) {
    // Get the appointmentID from the route parameters
    var appointmentID = req.params.appointmentID;

    // Get the status from the request body
    var status = req.body.status;

    // Call the updateAppointmentStatus function to update the appointment status
    updateAppointmentStatus(appointmentID, status, function(err, result) {
        if (err) {
            console.error('Error updating appointment status:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Send the result as JSON response
        res.json(result);
    });
});

// Define the function to update appointment status
function updateAppointmentStatus(appointmentID, status, callback) {
    // connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // create Request object
        var request = new sql.Request();

        // Set up input parameters for the stored procedure
        request.input('AppointmentID', sql.Int, appointmentID);
        request.input('Status', sql.VarChar(25), status);

        // Execute the stored procedure
        request.execute('Update_Appointment_Status', function (err, recordset) {
            if (err) {
                console.log('Error executing stored procedure:', err);
                return callback(err, null);
            }
            console.log('Appointment status updated successfully');

            callback(null, recordset);
        });
    });
}

app.get('/medicines', function(req, res) {
    // Connect to the database
    sql.connect(config, function(err) {
        if (err) {
            console.error('Error connecting to database:', err);
            return res.status(500).send('Internal Server Error');
        }

        console.log('Connected to database successfully');

        // Create a SQL request object
        const request = new sql.Request();

        // Execute the query to select all medicines
        request.query(`SELECT * FROM Medicine`, function(err, recordset) {
            if (err) {
                console.error('Error executing query:', err);
                return res.status(500).send('Internal Server Error');
            }

            console.log('Fetched medicines from database:', recordset);

            // Send the medicines as JSON response
            res.json(recordset.recordset);
        });
    });
});

// Server-Side function to handle the TotalLabTest query
app.get('/total-lab-tests', function (req, res) {
    // Connect to the database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return res.status(500).send('Internal Server Error');
        }

        console.log('Connected to database successfully');

        // Create a request object
        var request = new sql.Request();

        // Execute the query to fetch all total lab tests
        request.query(`SELECT * FROM TotalLabTest`, function (err, recordset) {
            if (err) {
                console.log('Error executing query:', err);
                return res.status(500).send('Internal Server Error');
            }

            // Send the fetched lab tests as JSON response
            res.json(recordset.recordset);
        });
    });
});

app.get('/diagnosis', function (req, res) {
    // Connect to the database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return res.status(500).send('Internal Server Error');
        }

        console.log('Connected to database successfully');

        // Create a request object
        var request = new sql.Request();

        // Execute the query to fetch all total lab tests
        request.query(`SELECT * FROM Diagnosis`, function (err, recordset) {
            if (err) {
                console.log('Error executing query:', err);
                return res.status(500).send('Internal Server Error');
            }

            // Send the fetched lab tests as JSON response
            res.json(recordset.recordset);
        });
    });
});



app.post('/create-prescription', function(req, res) {
    // Get data from the request body
    var appointmentID = req.body.appointmentID;
    var clinicalNotes = req.body.clinicalNotes;
    var diagnosisID = req.body.diagnosisID;
    var description = req.body.description;

    // Call the createPrescription function
    createPrescription(appointmentID, clinicalNotes, diagnosisID, description, function(err, result) {
        if (err) {
            console.error('Error creating prescription:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Send the result as JSON response
        res.json(result);
    });
});

// Define the function to create a prescription
function createPrescription(appointmentID, clinicalNotes, diagnosisID, description, callback) {
    // connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // create Request object
        var request = new sql.Request();

        // Set up input parameters for the stored procedure
        request.input('AppointmentID', sql.Int, appointmentID);
        request.input('ClinicalNotes', sql.VarChar(sql.MAX), clinicalNotes);
        request.input('DiagnosisID', sql.Int, diagnosisID);
        request.input('Description', sql.VarChar(sql.MAX), description);

        // Execute the stored procedure
        request.execute('createPrescription', function (err, recordset) {
            if (err) {
                console.log('Error executing stored procedure:', err);
                return callback(err, null);
            }
            console.log('Prescription created successfully');

            callback(null, recordset);
        });
    });
}

app.post('/add-medicines-to-prescription', function(req, res) {
    // Get data from the request body
    var medicineID = req.body.medicineID;
    var frequency = req.body.frequency;
    var quantity = req.body.quantity;
    var dosage = req.body.dosage;
    var instructions = req.body.instructions;
    var medicineDuration = req.body.medicineDuration;

    // Call the addMedicinesToPrescription function
    addMedicinesToPrescription(medicineID, frequency, quantity, dosage, instructions, medicineDuration, function(err, result) {
        if (err) {
            console.error('Error adding medicines to prescription:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Send the result as JSON response
        res.json(result);
    });
});

// Define the function to add medicines to prescription
function addMedicinesToPrescription(medicineID, frequency, quantity, dosage, instructions, medicineDuration, callback) {
    // Connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.error('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // Create Request object
        var request = new sql.Request();

        // Set up input parameters for the stored procedure
        request.input('MedicineID', sql.Int, medicineID);
        request.input('Frequency', sql.VarChar(50), frequency);
        request.input('Quantity', sql.Int, quantity);
        request.input('Dosage', sql.VarChar(20), dosage);
        request.input('Instructions', sql.VarChar(sql.MAX), instructions);
        request.input('MedicineDuration', sql.Int, medicineDuration);

        // Execute the stored procedure
        request.execute('AddMedicinesToPrescription', function (err, recordset) {
            if (err) {
                console.error('Error executing stored procedure:', err);
                return callback(err, null);
            }
            console.log('Medicines added to prescription successfully');

            callback(null, recordset);
        });
    });
}

app.post('/add-test-to-prescription', function(req, res) {
    // Get data from the request body
    var testID = req.body.testID;

    // Call the addPrescriptionTest function
    addPrescriptionTest(testID, function(err, result) {
        if (err) {
            console.error('Error adding test to prescription:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Send the result as JSON response
        res.json(result);
    });
});

// Define the function to add a test to prescription
function addPrescriptionTest(testID, callback) {
    // Connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.error('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // Create Request object
        var request = new sql.Request();

        // Set up input parameters for the stored procedure
        request.input('TestID', sql.Int, testID);

        // Execute the stored procedure
        request.execute('addPrescriptionTest', function (err, recordset) {
            if (err) {
                console.error('Error executing stored procedure:', err);
                return callback(err, null);
            }
            console.log('Test added to prescription successfully');

            callback(null, recordset);
        });
    });
}

app.get('/prescription/details', function(req, res) {
    // Get the AppointmentID from the query parameters
    var appointmentID = req.query.appointmentID;

    // Call the getPrescriptionDetails function to fetch prescription details from the database
    getPrescriptionDetails(appointmentID, function(err, prescriptionDetails) {
        if (err) {
            console.error('Error fetching prescription details:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Check if prescription details were found
        if (!prescriptionDetails || prescriptionDetails.length === 0) {
            console.log('Prescription details not found');
            return res.status(404).send('Prescription details not found');
        }

        // Send the prescription details as JSON response
        res.json(prescriptionDetails);
    });
});

// Define the getPrescriptionDetails function
function getPrescriptionDetails(appointmentID, callback) {
    // connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // create Request object
        var request = new sql.Request();

        // Set up input parameters for the function
        request.input('AppointmentID', sql.Int, appointmentID);

        // Execute the function
        request.query(`select * from Prescription_Details(${appointmentID})`, function (err, recordset) {
            if (err) {
                console.log('Error executing query:', err);
                return callback(err, null);
            }
            console.log('Fetched prescription details from database:', recordset);

            callback(null, recordset.recordset);
        });
    });
}

app.get('/patient/lab/details', function(req, res) {
    // Get the AppointmentID and TestID from the query parameters
    var appointmentID = req.query.appointmentID;
    var testID = req.query.testID;

    // Call the getPatientLabDetails function to fetch patient lab details from the database
    getPatientLabDetails(appointmentID, testID, function(err, patientLabDetails) {
        if (err) {
            console.error('Error fetching patient lab details:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Check if prescription details were found
        if (!patientLabDetails || patientLabDetails.length === 0) {
            console.log('Patient lab details not found');
            return res.status(404).send('Patient lab details not found');
        }

        // Send the patient lab details as JSON response
        res.json(patientLabDetails);
    });
});

// Define the getPatientLabDetails function
function getPatientLabDetails(appointmentID, testID, callback) {
    // connect to your database
    sql.connect(config, function (err) {
        if (err) {
            console.log('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // create Request object
        var request = new sql.Request();

        // Set up input parameters for the function
        request.input('AppointmentID', sql.Int, appointmentID);
        request.input('TestID', sql.Int, testID);

        // Execute the function
        request.query(`select * from GetPatientLabProfile(${appointmentID},${testID})`, function (err, recordset) {
            if (err) {
                console.log('Error executing query:', err);
                return callback(err, null);
            }
            console.log('Fetched patient lab details from database:', recordset);

            callback(null, recordset.recordset);
        });
    });
}



var server = app.listen(3000, function () {
    console.log('Server is running..');
});