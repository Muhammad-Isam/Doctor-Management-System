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

app.post('/update-appointment-status', function(req, res) {
    // Get the appointmentID from the request body
    var appointmentID = req.body.appointmentID;

    // Call the Update_Appointment_Status procedure to update appointment status in the database
    updateAppointmentStatus(appointmentID, function(err, result) {
        if (err) {
            console.error('Error updating appointment status:', err);
            return res.status(500).send('Internal Server Error');
        }

        // Check if the appointment status was updated successfully
        if (result && result.rowsAffected && result.rowsAffected.length > 0 && result.rowsAffected[0] > 0) {
            console.log('Appointment status updated successfully');
            return res.status(200).send('Appointment status updated successfully');
        } else {
            console.log('No appointment found with the specified ID');
            return res.status(404).send('No appointment found with the specified ID');
        }
    });
});

// Define the function to update appointment status
function updateAppointmentStatus(appointmentID, callback) {
    // Connect to the database
    sql.connect(config, function(err) {
        if (err) {
            console.error('Error connecting to database:', err);
            return callback(err, null);
        }

        console.log('Connected to database successfully');

        // Create Request object
        var request = new sql.Request();

        // Set up input parameter for the procedure
        request.input('AppointmentID', sql.Int, appointmentID);

        // Execute the procedure
        request.execute('Update_Appointment_Status', function(err, result) {
            if (err) {
                console.error('Error executing procedure:', err);
                return callback(err, null);
            }

            callback(null, result);
        });
    });
}


var server = app.listen(3000, function () {
    console.log('Server is running..');
});